import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';
import 'package:sudoku/repositories/game_repository.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/entities/game_session.dart';
import 'package:sudoku/models/game_ui_notifier.dart';

/// Coordinateur entre [GameSession] (domaine), [GameUiNotifier] (UI éphémère)
/// et [GameRepository] (persistance). C'est l'unique point d'entrée exposé aux widgets.
///
/// Persistance : debounce 500ms après mutation, flush synchrone via [flushSave]
/// (à appeler sur AppLifecycleState.paused/detached).
class GameController extends ChangeNotifier {
  GameController({
    required GameRepository repository,
    required ValidationModeEnum Function() validationModeProvider,
  }) : _repository = repository,
       _validationModeProvider = validationModeProvider {
    _ui.addListener(_onUiChanged);
  }

  final GameRepository _repository;
  final ValidationModeEnum Function() _validationModeProvider;
  GameSession? _session;
  final GameUiNotifier _ui = GameUiNotifier();
  final Random _random = Random();
  Timer? _saveTimer;
  bool _saveEnabled = true;
  ({bool notesMode, bool fillMode, int? activeNumber}) _lastPersistedUi = (
    notesMode: false,
    fillMode: false,
    activeNumber: null,
  );

  // --- Accesseurs ---

  bool get isInitialized => _session != null;
  GameSession get session => _session!;
  GameUiNotifier get uiState => _ui;

  DifficultyEnum get difficulty => session.difficulty;
  bool get isComplete => session.isComplete;
  Duration get elapsed => session.elapsed;
  Duration? get completedDuration => session.completedDuration;
  int get errorCount => session.errorCount;
  int get hintsUsed => session.hintsUsed;
  bool get canUndo => session.canUndo;
  ValidationModeEnum get validationMode => _validationModeProvider();

  int? get selectedIndex => _ui.selectedIndex;
  bool get notesMode => _ui.notesMode;
  bool get fillMode => _ui.fillMode;
  int? get activeNumber => _ui.activeNumber;

  // --- Tile state queries ---

  int valueAt(int index) => session.valueAt(index);
  Set<int> notesAt(int index) => session.notesAt(index);
  bool isGiven(int index) => session.isGiven(index);
  bool hasError(int index) => session.hasVisibleError(index);
  bool isNumberCompleted(int number) => session.isNumberCompleted(number);
  bool isSelected(int index) => _ui.selectedIndex == index;

  bool isRelated(int index) {
    final sel = _ui.selectedIndex;
    if (sel == null || index == sel) return false;
    final r = index ~/ 9, c = index % 9;
    final sr = sel ~/ 9, sc = sel % 9;
    return r == sr || c == sc || (r ~/ 3 == sr ~/ 3 && c ~/ 3 == sc ~/ 3);
  }

  bool isSameValue(int index) {
    final ref = _ui.fillMode
        ? _ui.activeNumber
        : (_ui.selectedIndex != null
              ? session.valueAt(_ui.selectedIndex!)
              : null);
    if (ref == null || ref == 0) return false;
    return session.valueAt(index) == ref && index != _ui.selectedIndex;
  }

  // --- Initialisation ---

  void initNewGame(DifficultyEnum diff) {
    _session = GameSession.newGame(diff);
    _saveEnabled = true;
    _ui.reset();
    _lastPersistedUi = (notesMode: false, fillMode: false, activeNumber: null);
    _scheduleSave();
    notifyListeners();
  }

  /// Initialise depuis des données déjà générées (typiquement par un isolate).
  /// Évite de bloquer le thread principal sur la génération.
  void initFromGenerated({
    required DifficultyEnum difficulty,
    required List<int> solution,
    required List<int> givens,
  }) {
    _session = GameSession.fromGenerated(
      difficulty: difficulty,
      solution: solution,
      givens: givens,
    );
    _saveEnabled = true;
    _ui.reset();
    _lastPersistedUi = (notesMode: false, fillMode: false, activeNumber: null);
    _scheduleSave();
    notifyListeners();
  }

  /// Restaure depuis un JSON. Retourne true si réussi, false si JSON invalide.
  /// Le caller est responsable d'effacer le blob corrompu si false.
  bool restoreFromJson(Map<String, dynamic> json) {
    final restored = GameSession.fromJson(json);
    if (restored == null) return false;
    _session = restored;
    _saveEnabled = true;
    final uiJson = json['ui'];
    if (uiJson is Map<String, dynamic>) {
      _ui.restoreFromJson(uiJson);
    } else {
      _ui.reset();
    }
    _lastPersistedUi = (
      notesMode: _ui.notesMode,
      fillMode: _ui.fillMode,
      activeNumber: _ui.activeNumber,
    );
    // Pas de scheduleSave : on vient juste de lire, pas la peine de réécrire.
    notifyListeners();
    return true;
  }

  // --- Actions utilisateur ---

  void onTileTap(int index) {
    if (_ui.fillMode && session.userGrid[index] != 0) {
      _ui.setActiveNumber(session.userGrid[index]);
    } else if (_ui.fillMode && _ui.activeNumber != null) {
      final changed = _ui.notesMode
          ? session.toggleNote(index, _ui.activeNumber!)
          : session.applyValue(
              index,
              _ui.activeNumber!,
              validationMode: validationMode,
            );
      if (changed) {
        _syncCompletedNumberState();
        _scheduleSave();
        notifyListeners();
      }
    }

    _ui.select(index);
  }

  void onNumberPadTap(int number) {
    if (_ui.fillMode) {
      _ui.setActiveNumber(_ui.activeNumber == number ? null : number);
      _ui.select(null);
      return;
    }
    final idx = _ui.selectedIndex;
    if (idx == null) return;
    final changed = _ui.notesMode
        ? session.toggleNote(idx, number)
        : session.applyValue(idx, number, validationMode: validationMode);
    if (changed) {
      _syncCompletedNumberState();
      _scheduleSave();
      notifyListeners();
    }
  }

  void eraseCell() {
    final idx = _ui.selectedIndex;
    if (idx == null) return;
    if (session.eraseCell(idx)) {
      _syncCompletedNumberState();
      _scheduleSave();
      notifyListeners();
    }
  }

  void toggleNotesMode() => _ui.toggleNotesMode();
  void toggleFillMode() => _ui.toggleFillMode();

  void undo() {
    if (session.undo()) {
      _syncCompletedNumberState();
      _scheduleSave();
      notifyListeners();
    }
  }

  void hint() {
    final target = session.applyHint(_random);
    if (target != null) {
      _syncCompletedNumberState();
      _ui.select(target);
      _scheduleSave();
      notifyListeners();
    }
  }

  void validateBoard() {
    session.validateBoard();
    _syncCompletedNumberState();
    _scheduleSave();
    notifyListeners();
  }

  Future<void> abandonGame() async {
    _saveEnabled = false;
    _saveTimer?.cancel();
    try {
      await _repository.clear();
    } catch (e, st) {
      debugPrint('GameController.abandonGame failed: $e\n$st');
    }
  }

  // --- Persistance ---

  void _onUiChanged() {
    // Seuls les modes UI (notesMode/fillMode/activeNumber) sont persistés.
    // Pour éviter une écriture disque sur chaque sélection de case,
    // on ne schedule un save que si une valeur persistable a changé.
    final current = (
      notesMode: _ui.notesMode,
      fillMode: _ui.fillMode,
      activeNumber: _ui.activeNumber,
    );
    if (current != _lastPersistedUi) {
      _lastPersistedUi = current;
      _scheduleSave();
    }
    notifyListeners();
  }

  void _scheduleSave() {
    if (!_saveEnabled) return;
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 500), _flushSave);
  }

  /// Annule le debounce et écrit immédiatement.
  /// À appeler sur AppLifecycleState.paused/detached et avant pop.
  Future<void> flushSave() async {
    _saveTimer?.cancel();
    await _flushSave();
  }

  Future<void> _flushSave() async {
    if (_session == null || !_saveEnabled) return;
    try {
      if (session.isComplete) {
        await _repository.clear();
      } else {
        await _repository.save({...session.toJson(), 'ui': _ui.toJson()});
      }
    } catch (e, st) {
      debugPrint('GameController._flushSave failed: $e\n$st');
    }
  }

  void _syncCompletedNumberState() {
    final number = _ui.activeNumber;
    if (number != null && session.isNumberCompleted(number)) {
      _ui.setActiveNumber(null);
    }
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    _ui.removeListener(_onUiChanged);
    _ui.dispose();
    super.dispose();
  }
}
