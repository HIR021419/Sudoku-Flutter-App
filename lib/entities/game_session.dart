import 'dart:math';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/entities/undo_cell.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';
import 'package:sudoku/utils/board_geometry.dart';
import 'package:sudoku/utils/migration_utils.dart';
import 'package:sudoku/utils/sudoku_utils.dart';

/// État domaine d'une partie en cours. Pas de ChangeNotifier — les changements
/// sont visibles via le GameController qui possède cette instance.
class GameSession {
  GameSession._({
    required this.difficulty,
    required this.solution,
    required this.userGrid,
    required this.givens,
    required Map<int, Set<int>> notes,
    required List<UndoEntry> undoStack,
    required Set<int> revealedErrors,
    required Set<int> validatedCorrect,
    required int errorCount,
    required int hintsUsed,
    required Duration elapsedAtRestore,
    required bool isComplete,
    required Duration? completedDuration,
  }) : _notes = notes,
       _undoStack = undoStack,
       _revealedErrors = revealedErrors,
       _validatedCorrect = validatedCorrect,
       _errorCount = errorCount,
       _hintsUsed = hintsUsed,
       _elapsedAtRestore = elapsedAtRestore,
       _isComplete = isComplete,
       _completedDuration = completedDuration {
    if (!_isComplete) {
      _stopwatch.start();
    }
  }

  /// Crée une nouvelle partie à la difficulté donnée. Génère solution + givens sur le thread courant.
  /// Pour éviter de bloquer l'UI sur Expert, préférer `GameSession.fromGenerated` couplé à `compute()`.
  factory GameSession.newGame(DifficultyEnum difficulty) {
    final solution = SudokuUtils.generateGrid();
    final givens = SudokuUtils.generateGivens(solution, difficulty);
    return GameSession.fromGenerated(
      difficulty: difficulty,
      solution: solution,
      givens: givens,
    );
  }

  /// Crée une partie à partir de données pré-générées (typiquement issues d'un isolate via `compute()`).
  factory GameSession.fromGenerated({
    required DifficultyEnum difficulty,
    required List<int> solution,
    required List<int> givens,
  }) {
    final givensSet = givens.toSet();
    final userGrid = List<int>.generate(
      81,
      (i) => givensSet.contains(i) ? solution[i] : 0,
    );
    return GameSession._(
      difficulty: difficulty,
      solution: solution,
      userGrid: userGrid,
      givens: givensSet,
      notes: {},
      undoStack: [],
      revealedErrors: {},
      validatedCorrect: {},
      errorCount: 0,
      hintsUsed: 0,
      elapsedAtRestore: Duration.zero,
      isComplete: false,
      completedDuration: null,
    );
  }

  /// Reconstruit une partie depuis un JSON. Retourne null si invalide
  /// (schema version inconnue, lengths/ranges hors limites, etc).
  static GameSession? fromJson(Map<String, dynamic> json) {
    try {
      final migratedJson = MigrationUtils.migrateToLatest(json);
      if (migratedJson == null) return null;

      final difficulty = DifficultyEnum.tryParse(
        migratedJson['difficulty'] as String?,
      );
      if (difficulty == null) return null;

      final solution = _readIntList(migratedJson['solution']);
      if (solution == null || solution.length != 81) return null;
      if (!solution.every((v) => v >= 1 && v <= 9)) return null;

      final userGrid = _readIntList(migratedJson['userGrid']);
      if (userGrid == null || userGrid.length != 81) return null;
      if (!userGrid.every((v) => v >= 0 && v <= 9)) return null;

      final givensList = _readIntList(migratedJson['givens']);
      if (givensList == null) return null;
      if (!givensList.every((i) => i >= 0 && i < 81)) return null;
      final givens = givensList.toSet();

      final notes = <int, Set<int>>{};
      final notesRaw = migratedJson['notes'];
      if (notesRaw is Map) {
        for (final entry in notesRaw.entries) {
          final keyStr = entry.key;
          if (keyStr is! String) return null;
          final idx = int.tryParse(keyStr);
          if (idx == null || idx < 0 || idx >= 81) return null;
          final values = _readIntList(entry.value);
          if (values == null) return null;
          if (!values.every((v) => v >= 1 && v <= 9)) return null;
          if (values.isNotEmpty) notes[idx] = values.toSet();
        }
      }

      final undoStack = <UndoEntry>[];
      final undoRaw = migratedJson['undoStack'];
      if (undoRaw is List) {
        for (final entry in undoRaw) {
          if (entry is! Map) return null;
          final cellsRaw = entry['cells'];
          if (cellsRaw is! List) return null;
          final entryCells = <UndoCell>[];
          for (final cell in cellsRaw) {
            if (cell is! Map<String, dynamic>) return null;
            entryCells.add(UndoCell.fromJson(cell));
          }
          if (entryCells.isNotEmpty) undoStack.add(entryCells);
        }
      }

      final revealedErrors = <int>{};
      final revealedErrorsRaw = _readIntList(migratedJson['revealedErrors']);
      if (revealedErrorsRaw != null) {
        if (!revealedErrorsRaw.every((i) => i >= 0 && i < 81)) return null;
        revealedErrors.addAll(revealedErrorsRaw);
      }

      final validatedCorrect = <int>{};
      final validatedCorrectRaw = _readIntList(
        migratedJson['validatedCorrect'],
      );
      if (validatedCorrectRaw != null) {
        if (!validatedCorrectRaw.every((i) => i >= 0 && i < 81)) return null;
        validatedCorrect.addAll(validatedCorrectRaw);
      }

      final errorCount = (migratedJson['errorCount'] as num?)?.toInt() ?? 0;
      final hintsUsed = (migratedJson['hintsUsed'] as num?)?.toInt() ?? 0;
      if (errorCount < 0 || hintsUsed < 0) return null;

      final elapsedMs = (migratedJson['elapsedMs'] as num?)?.toInt() ?? 0;
      if (elapsedMs < 0 || elapsedMs > Duration.millisecondsPerDay) return null;

      return GameSession._(
        difficulty: difficulty,
        solution: solution,
        userGrid: userGrid,
        givens: givens,
        notes: notes,
        undoStack: undoStack,
        revealedErrors: revealedErrors,
        validatedCorrect: validatedCorrect,
        errorCount: errorCount,
        hintsUsed: hintsUsed,
        elapsedAtRestore: Duration(milliseconds: elapsedMs),
        isComplete: false,
        completedDuration: null,
      );
    } catch (_) {
      return null;
    }
  }

  static List<int>? _readIntList(dynamic raw) {
    if (raw is! List) return null;
    final result = <int>[];
    for (final v in raw) {
      if (v is num) {
        result.add(v.toInt());
      } else {
        return null;
      }
    }
    return result;
  }

  // --- Données immuables après création ---
  final DifficultyEnum difficulty;
  final List<int> solution;
  final List<int> userGrid;
  final Set<int> givens;

  // --- Données qui évoluent au cours de la partie ---
  final Map<int, Set<int>> _notes;
  final List<UndoEntry> _undoStack;
  final Set<int> _revealedErrors;
  final Set<int> _validatedCorrect;
  int _errorCount;
  int _hintsUsed;
  bool _isComplete;
  Duration? _completedDuration;

  // --- Chronométrie ---
  final Stopwatch _stopwatch = Stopwatch();
  Duration _elapsedAtRestore;

  // --- Accesseurs ---
  Duration get elapsed => _stopwatch.elapsed + _elapsedAtRestore;
  bool get isComplete => _isComplete;
  Duration? get completedDuration => _completedDuration;
  int get errorCount => _errorCount;
  int get hintsUsed => _hintsUsed;
  bool get canUndo => _undoStack.isNotEmpty;
  bool get isFilled => !userGrid.contains(0);

  int valueAt(int index) => userGrid[index];
  Set<int> notesAt(int index) => _notes[index] ?? const {};
  bool isGiven(int index) => givens.contains(index);
  bool hasVisibleError(int index) => _revealedErrors.contains(index);
  bool isNumberCompleted(int number) {
    for (int i = 0; i < 81; i++) {
      if (solution[i] != number) continue;
      if (userGrid[i] != number) return false;
      if (!givens.contains(i) && !_validatedCorrect.contains(i)) return false;
    }
    return true;
  }

  // --- Sérialisation ---
  Map<String, dynamic> toJson() {
    return {
      'schemaVersion': kSessionSchemaVersion,
      'difficulty': difficulty.name,
      'solution': solution,
      'userGrid': userGrid,
      'givens': givens.toList(),
      'notes': _notes.map((k, v) => MapEntry(k.toString(), v.toList())),
      'undoStack': _undoStack
          .map((entry) => {'cells': entry.map((c) => c.toJson()).toList()})
          .toList(),
      'revealedErrors': _revealedErrors.toList(),
      'validatedCorrect': _validatedCorrect.toList(),
      'errorCount': _errorCount,
      'hintsUsed': _hintsUsed,
      'elapsedMs': elapsed.inMilliseconds,
    };
  }

  // --- Mutations domaine ---

  /// Place une valeur dans une case. Retourne true si l'état a changé.
  bool applyValue(
    int index,
    int value, {
    required ValidationModeEnum validationMode,
  }) {
    if (givens.contains(index)) return false;
    final oldValue = userGrid[index];
    if (oldValue == value) return false; // no-op : pas de undo phantom

    final entry = _snapshotForValue(index, value);
    _undoStack.add(entry);
    _capUndoStack();

    userGrid[index] = value;
    _notes.remove(index);
    _clearCellValidation(index);
    _autoCleanNotes(index, value);
    switch (validationMode) {
      case ValidationModeEnum.autoCheck:
        if (value == solution[index]) {
          _validatedCorrect.add(index);
          _checkWin();
        } else {
          _revealedErrors.add(index);
          _errorCount++;
        }
      case ValidationModeEnum.validate:
        break;
      case ValidationModeEnum.noCheck:
        if (isFilled) {
          validateBoard();
        }
        break;
    }
    return true;
  }

  /// Toggle une note dans une case vide. Retourne true si l'état a changé.
  bool toggleNote(int index, int value) {
    if (givens.contains(index)) return false;
    if (userGrid[index] != 0) return false;

    final entry = <UndoCell>[
      UndoCell(
        index: index,
        value: userGrid[index],
        notes: Set<int>.from(_notes[index] ?? const {}),
        hasVisibleError: _revealedErrors.contains(index),
        isValidatedCorrect: _validatedCorrect.contains(index),
      ),
    ];
    _undoStack.add(entry);
    _capUndoStack();

    final set = _notes.putIfAbsent(index, () => <int>{});
    if (set.contains(value)) {
      set.remove(value);
    } else {
      set.add(value);
    }
    if (set.isEmpty) _notes.remove(index);
    return true;
  }

  /// Efface la valeur d'une case (et ses notes). Retourne true si l'état a changé.
  bool eraseCell(int index) {
    if (givens.contains(index)) return false;
    if (userGrid[index] == 0 && (_notes[index]?.isEmpty ?? true)) {
      return false;
    }
    final entry = <UndoCell>[
      UndoCell(
        index: index,
        value: userGrid[index],
        notes: Set<int>.from(_notes[index] ?? const {}),
        hasVisibleError: _revealedErrors.contains(index),
        isValidatedCorrect: _validatedCorrect.contains(index),
      ),
    ];
    _undoStack.add(entry);
    _capUndoStack();

    userGrid[index] = 0;
    _notes.remove(index);
    _clearCellValidation(index);
    return true;
  }

  /// Annule la dernière mutation. Retourne true si quelque chose a été annulé.
  /// **Volontairement non décrémente _errorCount et _hintsUsed** (anti-triche).
  bool undo() {
    if (_undoStack.isEmpty) return false;
    final entry = _undoStack.removeLast();
    for (final cell in entry) {
      _clearCellValidation(cell.index);
    }
    for (final cell in entry) {
      userGrid[cell.index] = cell.value;
      if (cell.notes.isEmpty) {
        _notes.remove(cell.index);
      } else {
        _notes[cell.index] = Set<int>.from(cell.notes);
      }
      if (cell.hasVisibleError) {
        _revealedErrors.add(cell.index);
      }
      if (cell.isValidatedCorrect) {
        _validatedCorrect.add(cell.index);
      }
    }
    // Si on annule depuis un état gagnant, on repasse en cours.
    if (_isComplete) {
      _isComplete = false;
      _completedDuration = null;
      if (!_stopwatch.isRunning) _stopwatch.start();
    }
    return true;
  }

  /// Révèle la valeur correcte d'une case vide ou erronée.
  /// Retourne l'index ciblé, ou null si rien à révéler.
  int? applyHint(Random random) {
    final candidates = <int>[];
    for (int i = 0; i < 81; i++) {
      if (!givens.contains(i) && userGrid[i] != solution[i]) {
        candidates.add(i);
      }
    }
    if (candidates.isEmpty) return null;
    final target = candidates[random.nextInt(candidates.length)];

    final entry = _snapshotForValue(target, solution[target]);
    _undoStack.add(entry);
    _capUndoStack();

    userGrid[target] = solution[target];
    _notes.remove(target);
    _clearCellValidation(target);
    _validatedCorrect.add(target);
    _autoCleanNotes(target, solution[target]);
    _hintsUsed++;
    _checkWin();
    return target;
  }

  int validateBoard() {
    final nextRevealedErrors = <int>{};
    final nextValidatedCorrect = <int>{};

    for (int i = 0; i < 81; i++) {
      if (givens.contains(i)) continue;
      final value = userGrid[i];
      if (value == 0) continue;
      if (value == solution[i]) {
        nextValidatedCorrect.add(i);
      } else {
        nextRevealedErrors.add(i);
      }
    }

    var newErrors = 0;
    for (final index in nextRevealedErrors) {
      if (!_revealedErrors.contains(index)) {
        newErrors++;
      }
    }

    _revealedErrors
      ..clear()
      ..addAll(nextRevealedErrors);
    _validatedCorrect
      ..clear()
      ..addAll(nextValidatedCorrect);
    _errorCount += newErrors;
    _checkWin();
    return newErrors;
  }

  // --- Helpers privés ---

  /// Snapshot la cellule cible + toutes les cellules de la ligne/colonne/bloc
  /// dont les notes contiennent [value] (qui vont être nettoyées par _autoCleanNotes).
  UndoEntry _snapshotForValue(int index, int value) {
    UndoCell _snapshot(int idx) => UndoCell(
      index: idx,
      value: userGrid[idx],
      notes: Set<int>.from(_notes[idx] ?? const {}),
      hasVisibleError: _revealedErrors.contains(idx),
      isValidatedCorrect: _validatedCorrect.contains(idx),
    );

    final entry = <UndoCell>[_snapshot(index)];
    for (final idx in peerIndexesOf(index)) {
      final cellNotes = _notes[idx];
      if (cellNotes != null && cellNotes.contains(value)) {
        entry.add(_snapshot(idx));
      }
    }
    return entry;
  }

  void _clearCellValidation(int index) {
    _revealedErrors.remove(index);
    _validatedCorrect.remove(index);
  }

  void _autoCleanNotes(int index, int value) {
    void cleanAt(int idx) {
      final set = _notes[idx];
      if (set == null) return;
      set.remove(value);
      if (set.isEmpty) _notes.remove(idx);
    }

    cleanAt(index);
    for (final idx in peerIndexesOf(index)) {
      cleanAt(idx);
    }
  }

  void _capUndoStack() {
    while (_undoStack.length > 100) {
      _undoStack.removeAt(0);
    }
  }

  void _checkWin() {
    for (int i = 0; i < 81; i++) {
      if (userGrid[i] != solution[i]) return;
      if (!givens.contains(i) && !_validatedCorrect.contains(i)) return;
    }
    _isComplete = true;
    _completedDuration = elapsed;
    _stopwatch.stop();
  }
}
