import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/controllers/settings_notifier.dart';
import 'package:sudoku/entities/_schema_versions.dart';
import 'package:sudoku/entities/game_session.dart';
import 'package:sudoku/entities/migrations/game_session_migration.dart';
import 'package:sudoku/entities/settings.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';
import 'package:sudoku/models/game_session_runtime.dart';
import 'package:sudoku/models/game_state.dart';
import 'package:sudoku/models/game_ui_state.dart';
import 'package:sudoku/providers/repositories.dart';
import 'package:sudoku/services/sound_service.dart';
import 'package:sudoku/utils/board_geometry.dart';
import 'package:sudoku/utils/daily_challenge.dart';

part 'game_notifier.g.dart';

/// Notifier autoDispose qui pilote l'état d'une partie.
///
/// State **nullable** : `null` jusqu'à ce que la page appelle
/// `startFromGenerated()` ou `restoreFromJson()` en `initState`. L'UI affiche
/// un loader pendant cette frame initiale.
///
/// Lifecycle : le runtime (Stopwatch + Timer de save) est libéré via
/// `ref.onDispose`, déclenché par Riverpod quand la page quitte l'écran.
@riverpod
class GameNotifier extends _$GameNotifier {
  static const Duration _saveDebounce = Duration(milliseconds: 500);

  final GameSessionRuntime _runtime = GameSessionRuntime();
  final Random _random = Random();
  final SoundService _sound = SoundService();
  Timer? _saveTimer;
  bool _saveEnabled = true;
  ({bool notesMode, bool fillMode, int? activeNumber}) _lastPersistedUi = (
    notesMode: false,
    fillMode: false,
    activeNumber: null,
  );

  @override
  GameState? build() {
    ref.onDispose(_disposeRuntime);
    // Fix — passage en « vérification auto » : dès que le mode bascule vers
    // autoCheck (depuis manuel/sans vérif), on relance une vérification
    // complète de la grille en cours (erreurs révélées, cases correctes
    // validées). Effet visible au retour sur la partie.
    ref.listen(
      settingsNotifierProvider.select((s) => s.valueOrNull?.validationMode),
      (prev, next) {
        if (next == ValidationModeEnum.autoCheck &&
            prev != null &&
            prev != ValidationModeEnum.autoCheck) {
          _runFullAutoCheck();
        }
      },
    );
    return null;
  }

  /// Re-vérifie toute la grille (utilisé au passage en mode autoCheck).
  void _runFullAutoCheck() {
    final s = state;
    if (s == null || s.session.isComplete) return;
    _applySession(s.session.validateBoardWithReport().session);
  }

  // --- Initialisation ---

  /// Démarre une nouvelle partie depuis des données déjà générées.
  void startFromGenerated({
    required DifficultyEnum difficulty,
    required List<int> solution,
    required List<int> givens,
  }) {
    final session = GameSession.fromGenerated(
      difficulty: difficulty,
      solution: solution,
      givens: givens,
    );
    _runtime.startFresh();
    _saveEnabled = true;
    _lastPersistedUi = (notesMode: false, fillMode: false, activeNumber: null);
    state = GameState(session: session);
    _scheduleSave();
  }

  /// Démarre le défi du jour (difficulté fixe, grille déterministe).
  /// La persistance de reprise est **désactivée** : le défi ne crée pas de
  /// slot de sauvegarde (une seule tentative par jour, pas de reprise).
  void startDaily({required List<int> solution, required List<int> givens}) {
    final session = GameSession.fromGenerated(
      difficulty: dailyDifficulty,
      solution: solution,
      givens: givens,
    );
    _runtime.startFresh();
    _saveEnabled = false;
    _lastPersistedUi = (notesMode: false, fillMode: false, activeNumber: null);
    state = GameState(session: session);
  }

  /// Restaure depuis un JSON. Retourne `true` si réussi, `false` si invalide
  /// (le caller doit alors clear le blob et afficher un message).
  bool restoreFromJson(Map<String, dynamic> json) {
    final migrated = GameSessionMigration.migrate(json);
    if (migrated == null) return false;

    final GameSession session;
    try {
      session = GameSession.fromJson(migrated);
    } catch (_) {
      return false;
    }

    final wasComplete = session.isComplete;
    _runtime.restoreFrom(session.elapsedAtRestore, running: !wasComplete);
    _saveEnabled = true;

    final uiJson = json['ui'];
    final ui = uiJson is Map<String, dynamic>
        ? GameUiState.fromJsonLenient(uiJson)
        : const GameUiState();
    _lastPersistedUi = (
      notesMode: ui.notesMode,
      fillMode: ui.fillMode,
      activeNumber: ui.activeNumber,
    );

    state = GameState(
      session: session,
      ui: ui,
      completedDuration: wasComplete ? session.elapsedAtRestore : null,
    );
    // Pas de scheduleSave : on vient juste de lire.
    return true;
  }

  // --- Accesseurs runtime (non-state) ---

  /// Durée totale (live) — utilisée par le widget WinDialog et au flushSave.
  Duration get elapsed => _runtime.totalElapsed;

  ValidationModeEnum get _validationMode =>
      ref.read(settingsNotifierProvider).valueOrNull?.validationMode ??
      const Settings().validationMode;

  bool get _soundEnabled =>
      ref.read(settingsNotifierProvider).valueOrNull?.soundEnabled ??
      const Settings().soundEnabled;

  // --- Actions utilisateur ---

  void onTileTap(int index) {
    final s = state;
    if (s == null) return;
    final session = s.session;
    final ui = s.ui;

    // #13 — En fillMode (mode valeur, autoCheck), taper une case déjà en
    // erreur avec un chiffre actif doit y écrire le chiffre actif plutôt que
    // de basculer l'activeNumber sur la valeur erronée. On laisse donc passer
    // ce cas vers le bloc d'application ci-dessous.
    final canOverwriteError =
        _validationMode == ValidationModeEnum.autoCheck &&
        !ui.notesMode &&
        ui.activeNumber != null &&
        session.hasVisibleError(index);

    if (ui.fillMode && session.valueAt(index) != 0 && !canOverwriteError) {
      _setUi(ui.copyWith(activeNumber: session.valueAt(index)));
      _selectInternal(index);
      return;
    }

    if (ui.fillMode && ui.activeNumber != null) {
      final active = ui.activeNumber!;

      // #6 — En mode note, on bascule la note sans poser de highlight de
      // sélection bleu sur la case (l'attention reste sur l'activeNumber).
      if (ui.notesMode) {
        _applySession(session.toggleNote(index, active));
        _selectInternal(null);
        return;
      }

      final next = session.applyValue(
        index,
        active,
        validationMode: _validationMode,
      );
      _applySession(next);
      // Si l'activeNumber vient d'être complété, _applySession l'a auto-avancé.
      // La cellule fraîchement remplie contient désormais le chiffre devenu
      // inactif — la sélectionner placerait un highlight sur un chiffre qu'on
      // a quitté → on désélectionne à la place.
      if (next.isNumberCompleted(active)) {
        _selectInternal(null);
        return;
      }
    }

    _selectInternal(index);
  }

  void onNumberPadTap(int number) {
    final s = state;
    if (s == null) return;
    final session = s.session;
    final ui = s.ui;

    if (ui.fillMode) {
      final selecting = ui.activeNumber != number; // active → null = désélection
      _setUi(
        ui.copyWith(
          activeNumber: ui.activeNumber == number ? null : number,
          selectedIndex: null,
        ),
      );
      if (selecting && _soundEnabled) _sound.tap();
      return;
    }

    final idx = ui.selectedIndex;
    if (idx == null) return;
    final next = ui.notesMode
        ? session.toggleNote(idx, number)
        : session.applyValue(idx, number, validationMode: _validationMode);
    _applySession(next);
  }

  void eraseCell() {
    final s = state;
    if (s == null) return;
    final idx = s.ui.selectedIndex;
    if (idx == null) return;
    _applySession(s.session.eraseCell(idx));
  }

  void undo() {
    final s = state;
    if (s == null) return;
    _applySession(s.session.undo());
  }

  void hint() {
    final s = state;
    if (s == null) return;
    final active = s.ui.activeNumber;
    final result = s.session.applyHint(_random);
    final target = result.target;
    if (target == null) return;
    final placedValue = result.session.valueAt(target);
    _applySession(result.session);
    // Même logique que onTileTap : si le hint vient de compléter
    // l'activeNumber courant, la cible contient le chiffre devenu
    // inactif → désélectionne plutôt que de pointer dessus.
    if (active != null &&
        placedValue == active &&
        result.session.isNumberCompleted(active)) {
      _selectInternal(null);
      return;
    }
    _selectInternal(target);
  }

  void validateBoard() {
    final s = state;
    if (s == null) return;
    _applySession(s.session.validateBoardWithReport().session);
  }

  void toggleNotesMode() {
    final s = state;
    if (s == null) return;
    _setUi(s.ui.copyWith(notesMode: !s.ui.notesMode));
  }

  void toggleFillMode() {
    final s = state;
    if (s == null) return;
    final ui = s.ui;
    _setUi(
      ui.copyWith(
        fillMode: !ui.fillMode,
        selectedIndex: !ui.fillMode ? null : ui.selectedIndex,
        activeNumber: null,
      ),
    );
  }

  void selectTile(int? index) => _selectInternal(index);

  /// Annule le debounce et écrit immédiatement.
  /// À appeler sur AppLifecycleState.paused/detached et avant pop.
  Future<void> flushSave() async {
    _saveTimer?.cancel();
    await _flushSave();
  }

  // --- Helpers présentation (UI dérivée) ---
  // Exposés pour les widgets qui ont besoin de dérivés non-trivaux.
  // Les widgets les appellent via ref.read(gameNotifierProvider.notifier).xxx
  // ou via ref.watch(gameNotifierProvider) puis méthodes pures sur le state.

  bool isRelated(int index) {
    final ui = state?.ui;
    final sel = ui?.selectedIndex;
    if (sel == null || index == sel) return false;
    return rowOf(index) == rowOf(sel) ||
        colOf(index) == colOf(sel) ||
        boxOf(index) == boxOf(sel);
  }

  bool isSameValue(int index) {
    final s = state;
    if (s == null) return false;
    final ref0 = s.ui.fillMode
        ? s.ui.activeNumber
        : (s.ui.selectedIndex != null
              ? s.session.valueAt(s.ui.selectedIndex!)
              : null);
    if (ref0 == null || ref0 == 0) return false;
    return s.session.valueAt(index) == ref0 && index != s.ui.selectedIndex;
  }

  // --- Pipeline de mutation ---

  /// Adopte une nouvelle session, détecte la transition de victoire, schedule
  /// save. Court-circuit si l'entité est identique (méthode pure → `this`).
  void _applySession(GameSession next) {
    final current = state;
    if (current == null) return;
    if (identical(next, current.session)) return;

    final wasComplete = current.session.isComplete;
    final isCompleteNow = next.isComplete;

    // Sons (#5) — best-effort, conditionnés à soundEnabled.
    if (_soundEnabled) {
      if (!wasComplete && isCompleteNow) {
        _sound.win();
      } else if (next.errorCount > current.session.errorCount) {
        _sound.error();
      }
    }

    Duration? completedDuration = current.completedDuration;
    if (!wasComplete && isCompleteNow) {
      completedDuration = _runtime.totalElapsed;
      _runtime.stop();
    } else if (wasComplete && !isCompleteNow) {
      completedDuration = null;
      _runtime.start();
    }

    var nextUi = current.ui;
    // Synchronise l'active number : si le nombre actif vient d'être complété,
    // on bascule sur le prochain nombre non-complété (UX continue en fillMode).
    // Si tous les nombres sont complétés, on retombe sur null.
    final activeNumber = nextUi.activeNumber;
    if (activeNumber != null && next.isNumberCompleted(activeNumber)) {
      nextUi = nextUi.copyWith(
        activeNumber: _findNextIncompleteNumber(next, activeNumber),
      );
    }

    state = current.copyWith(
      session: next,
      ui: nextUi,
      completedDuration: completedDuration,
    );
    _onUiPossiblyChanged(nextUi);
    _scheduleSave();
  }

  /// Cherche, en partant de [from] (exclu) et en bouclant, le prochain nombre
  /// 1..9 qui n'est PAS encore complété dans [session]. Retourne `null` si
  /// tous les nombres sont complétés.
  int? _findNextIncompleteNumber(GameSession session, int from) {
    for (int offset = 1; offset <= 9; offset++) {
      final candidate = ((from - 1 + offset) % 9) + 1;
      if (!session.isNumberCompleted(candidate)) return candidate;
    }
    return null;
  }

  void _setUi(GameUiState next) {
    final current = state;
    if (current == null) return;
    if (next == current.ui) return;
    state = current.copyWith(ui: next);
    _onUiPossiblyChanged(next);
  }

  void _selectInternal(int? index) {
    final current = state;
    if (current == null) return;
    if (current.ui.selectedIndex == index) return;
    state = current.copyWith(ui: current.ui.copyWith(selectedIndex: index));
    // Son de tap (#5) sur une vraie sélection de case (pas sur désélection).
    if (index != null && _soundEnabled) _sound.tap();
    // Pas de save : selectedIndex n'est pas persisté.
  }

  void _onUiPossiblyChanged(GameUiState ui) {
    // Persistance debounce uniquement si une valeur persistable a changé.
    final current = (
      notesMode: ui.notesMode,
      fillMode: ui.fillMode,
      activeNumber: ui.activeNumber,
    );
    if (current != _lastPersistedUi) {
      _lastPersistedUi = current;
      _scheduleSave();
    }
  }

  // --- Persistance ---

  void _scheduleSave() {
    if (!_saveEnabled) return;
    _saveTimer?.cancel();
    _saveTimer = Timer(_saveDebounce, _flushSave);
  }

  Future<void> _flushSave() async {
    final s = state;
    if (s == null || !_saveEnabled) return;
    final repo = ref.read(gameRepositoryProvider);
    try {
      if (s.session.isComplete) {
        await repo.clear();
      } else {
        final snapshot = s.session.copyWith(
          elapsedAtRestore: _runtime.totalElapsed,
        );
        await repo.save({
          ...snapshot.toJson(),
          'schemaVersion': kGameSessionSchemaVersion,
          'ui': s.ui.toJson(),
        });
      }
    } catch (e, st) {
      debugPrint('GameNotifier._flushSave failed: $e\n$st');
    }
  }

  void _disposeRuntime() {
    _saveTimer?.cancel();
    _runtime.stop();
    _sound.dispose();
    // Pas de _flushSave ici : la page appelle flushSave() en dispose()
    // et didChangeAppLifecycleState. Faire un await dans onDispose est risqué.
  }
}
