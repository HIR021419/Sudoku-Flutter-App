// ignore_for_file: invalid_annotation_target
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sudoku/entities/_converters.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';
import 'package:sudoku/entities/undo_cell.dart';
import 'package:sudoku/utils/board_geometry.dart';
import 'package:sudoku/utils/sudoku_utils.dart';

part 'game_session.freezed.dart';
part 'game_session.g.dart';

// ---------------------------------------------------------------------------
// Converter privé : encode List<UndoEntry> sous la forme [{cells: [...]}, ...]
// Délègue aux fromJson/toJson de UndoCell.
// ---------------------------------------------------------------------------

class _UndoStackConverter
    implements JsonConverter<List<UndoEntry>, List<dynamic>> {
  const _UndoStackConverter();

  @override
  List<UndoEntry> fromJson(List<dynamic> json) => json.map((entry) {
    final cells = (entry as Map)['cells'] as List<dynamic>;
    return cells
        .map((c) => UndoCell.fromJson(c as Map<String, dynamic>))
        .toList();
  }).toList();

  @override
  List<dynamic> toJson(List<UndoEntry> stack) => stack
      .map((entry) => {'cells': entry.map((c) => c.toJson()).toList()})
      .toList();
}

// ---------------------------------------------------------------------------
// GameSession — immuable, freezed, pure.
//
// Toutes les méthodes métier (applyValue, eraseCell, toggleNote, undo,
// applyHint, validateBoard) retournent une **nouvelle** instance via copyWith.
// Si l'opération n'a pas d'effet, elles retournent `this` (instance inchangée).
//
// L'état runtime (Stopwatch, sélection UI, mode notes/fill) **ne fait pas**
// partie de l'entité — il vit dans models/game_session_runtime.dart et
// models/game_ui_state.dart.
//
// `isComplete` et `completedDuration` ne sont plus stockés : `isComplete` est
// un getter pur, et `completedDuration` est capturé par le contrôleur au
// moment de la transition vers la victoire.
// ---------------------------------------------------------------------------

@freezed
abstract class GameSession with _$GameSession {
  const GameSession._();

  const factory GameSession({
    required DifficultyEnum difficulty,
    required List<int> solution,
    required List<int> userGrid,
    @IntSetConverter() required Set<int> givens,
    @NotesMapConverter() @Default(<int, Set<int>>{}) Map<int, Set<int>> notes,
    @_UndoStackConverter() @Default(<UndoEntry>[]) List<UndoEntry> undoStack,
    @IntSetConverter() @Default(<int>{}) Set<int> revealedErrors,
    @IntSetConverter() @Default(<int>{}) Set<int> validatedCorrect,
    @Default(0) int errorCount,
    @Default(0) int hintsUsed,
    @JsonKey(name: 'elapsedMs')
    @DurationMsConverter()
    @Default(Duration.zero)
    Duration elapsedAtRestore,
  }) = _GameSession;

  factory GameSession.fromJson(Map<String, dynamic> json) =>
      _$GameSessionFromJson(json);

  // --- Factories de construction métier ---

  /// Nouvelle partie. Préférer [GameSession.fromGenerated] couplé à `compute()`
  /// pour Expert (évite de bloquer l'UI).
  factory GameSession.newGame(DifficultyEnum difficulty) {
    final solution = SudokuUtils.generateGrid();
    final givens = SudokuUtils.generateGivens(solution, difficulty);
    return GameSession.fromGenerated(
      difficulty: difficulty,
      solution: solution,
      givens: givens,
    );
  }

  /// Partie à partir de données pré-générées (typiquement via `compute()`).
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
    return GameSession(
      difficulty: difficulty,
      solution: solution,
      userGrid: userGrid,
      givens: givensSet,
    );
  }

  // --- Accesseurs calculés ---

  bool get canUndo => undoStack.isNotEmpty;
  bool get isFilled => !userGrid.contains(0);

  int valueAt(int index) => userGrid[index];
  Set<int> notesAt(int index) => notes[index] ?? const {};
  bool isGiven(int index) => givens.contains(index);
  bool hasVisibleError(int index) => revealedErrors.contains(index);

  bool isNumberCompleted(int number) {
    for (int i = 0; i < 81; i++) {
      if (solution[i] != number) continue;
      if (userGrid[i] != number) return false;
      if (!givens.contains(i) && !validatedCorrect.contains(i)) return false;
    }
    return true;
  }

  /// Masque de bits des nombres déjà complétés (bit N-1 = nombre N).
  /// Utilisé par le pavé numérique pour griser les nombres terminés.
  int get completedNumbersMask {
    int mask = 0;
    for (int n = 1; n <= 9; n++) {
      if (isNumberCompleted(n)) mask |= 1 << (n - 1);
    }
    return mask;
  }

  /// Vrai si la grille est entièrement remplie ET toutes les cases non-givens
  /// sont marquées correctes. Getter pur — calculé à la demande.
  bool get isComplete {
    for (int i = 0; i < 81; i++) {
      if (userGrid[i] != solution[i]) return false;
      if (!givens.contains(i) && !validatedCorrect.contains(i)) return false;
    }
    return true;
  }

  // --- Mutations domaine (retournent une nouvelle instance) ---

  /// Place une valeur dans une case. Retourne `this` si aucun changement.
  GameSession applyValue(
    int index,
    int value, {
    required ValidationModeEnum validationMode,
  }) {
    if (givens.contains(index)) return this;
    if (userGrid[index] == value) return this;

    final entry = _snapshotForValue(index, value);
    final newUndoStack = _appendUndo(entry);

    final newUserGrid = List<int>.of(userGrid)..[index] = value;
    final newNotes = _autoCleanNotes(
      _removeNotesAt(notes, index),
      index,
      value,
    );
    final newRevealed = Set<int>.of(revealedErrors)..remove(index);
    final newValidated = Set<int>.of(validatedCorrect)..remove(index);
    var newErrorCount = errorCount;

    switch (validationMode) {
      case ValidationModeEnum.autoCheck:
        if (value == solution[index]) {
          newValidated.add(index);
        } else {
          newRevealed.add(index);
          newErrorCount++;
        }
      case ValidationModeEnum.validate:
        break;
      case ValidationModeEnum.noCheck:
        break;
    }

    var next = copyWith(
      userGrid: newUserGrid,
      notes: newNotes,
      undoStack: newUndoStack,
      revealedErrors: newRevealed,
      validatedCorrect: newValidated,
      errorCount: newErrorCount,
    );

    if (validationMode == ValidationModeEnum.noCheck && next.isFilled) {
      next = next.validateBoard();
    }
    return next;
  }

  /// Toggle une note dans une case vide. Retourne `this` si aucun changement.
  GameSession toggleNote(int index, int value) {
    if (givens.contains(index)) return this;
    if (userGrid[index] != 0) return this;

    final newUndoStack = _appendUndo([_snapshotCell(index)]);

    final cellNotes = Set<int>.of(notes[index] ?? const {});
    if (cellNotes.contains(value)) {
      cellNotes.remove(value);
    } else {
      cellNotes.add(value);
    }

    final newNotes = Map<int, Set<int>>.of(notes);
    if (cellNotes.isEmpty) {
      newNotes.remove(index);
    } else {
      newNotes[index] = cellNotes;
    }

    return copyWith(notes: newNotes, undoStack: newUndoStack);
  }

  /// Efface la valeur et les notes d'une case. Retourne `this` si aucun changement.
  GameSession eraseCell(int index) {
    if (givens.contains(index)) return this;
    if (userGrid[index] == 0 && (notes[index]?.isEmpty ?? true)) return this;

    final newUndoStack = _appendUndo([_snapshotCell(index)]);
    final newUserGrid = List<int>.of(userGrid)..[index] = 0;
    final newNotes = Map<int, Set<int>>.of(notes)..remove(index);
    final newRevealed = Set<int>.of(revealedErrors)..remove(index);
    final newValidated = Set<int>.of(validatedCorrect)..remove(index);

    return copyWith(
      userGrid: newUserGrid,
      notes: newNotes,
      undoStack: newUndoStack,
      revealedErrors: newRevealed,
      validatedCorrect: newValidated,
    );
  }

  /// Annule la dernière mutation. Retourne `this` si la pile est vide.
  /// Volontairement ne décrémente pas `errorCount` ni `hintsUsed` (anti-triche).
  GameSession undo() {
    if (undoStack.isEmpty) return this;

    final entry = undoStack.last;
    final newUndoStack = undoStack.sublist(0, undoStack.length - 1);

    final newUserGrid = List<int>.of(userGrid);
    final newNotes = Map<int, Set<int>>.of(notes);
    final newRevealed = Set<int>.of(revealedErrors);
    final newValidated = Set<int>.of(validatedCorrect);

    for (final cell in entry) {
      newRevealed.remove(cell.index);
      newValidated.remove(cell.index);
    }
    for (final cell in entry) {
      newUserGrid[cell.index] = cell.value;
      if (cell.notes.isEmpty) {
        newNotes.remove(cell.index);
      } else {
        newNotes[cell.index] = Set<int>.of(cell.notes);
      }
      if (cell.hasVisibleError) newRevealed.add(cell.index);
      if (cell.isValidatedCorrect) newValidated.add(cell.index);
    }

    return copyWith(
      userGrid: newUserGrid,
      notes: newNotes,
      undoStack: newUndoStack,
      revealedErrors: newRevealed,
      validatedCorrect: newValidated,
    );
  }

  /// Révèle une case erronée ou vide. Retourne `(session, target)` :
  /// `target` est l'index révélé, ou `null` si rien à révéler.
  ({GameSession session, int? target}) applyHint(Random random) {
    final candidates = <int>[];
    for (int i = 0; i < 81; i++) {
      if (!givens.contains(i) && userGrid[i] != solution[i]) {
        candidates.add(i);
      }
    }
    if (candidates.isEmpty) return (session: this, target: null);

    final target = candidates[random.nextInt(candidates.length)];
    final value = solution[target];

    final newUndoStack = _appendUndo(_snapshotForValue(target, value));
    final newUserGrid = List<int>.of(userGrid)..[target] = value;
    final newNotes = _autoCleanNotes(
      _removeNotesAt(notes, target),
      target,
      value,
    );
    final newRevealed = Set<int>.of(revealedErrors)..remove(target);
    final newValidated = Set<int>.of(validatedCorrect)..add(target);

    return (
      session: copyWith(
        userGrid: newUserGrid,
        notes: newNotes,
        undoStack: newUndoStack,
        revealedErrors: newRevealed,
        validatedCorrect: newValidated,
        hintsUsed: hintsUsed + 1,
      ),
      target: target,
    );
  }

  /// Re-valide toute la grille remplie. Retourne `(session, newErrors)` :
  /// `newErrors` est le nombre d'erreurs nouvellement révélées.
  ({GameSession session, int newErrors}) validateBoardWithReport() {
    final nextRevealed = <int>{};
    final nextValidated = <int>{};

    for (int i = 0; i < 81; i++) {
      if (givens.contains(i)) continue;
      final value = userGrid[i];
      if (value == 0) continue;
      if (value == solution[i]) {
        nextValidated.add(i);
      } else {
        nextRevealed.add(i);
      }
    }

    var newErrors = 0;
    for (final index in nextRevealed) {
      if (!revealedErrors.contains(index)) newErrors++;
    }

    return (
      session: copyWith(
        revealedErrors: nextRevealed,
        validatedCorrect: nextValidated,
        errorCount: errorCount + newErrors,
      ),
      newErrors: newErrors,
    );
  }

  /// Variante simple (sans report) — pratique pour la composition interne.
  GameSession validateBoard() => validateBoardWithReport().session;

  // --- Helpers internes ---

  static const int _undoStackCap = 100;

  UndoCell _snapshotCell(int idx) => UndoCell(
    index: idx,
    value: userGrid[idx],
    notes: Set<int>.of(notes[idx] ?? const {}),
    hasVisibleError: revealedErrors.contains(idx),
    isValidatedCorrect: validatedCorrect.contains(idx),
  );

  UndoEntry _snapshotForValue(int index, int value) {
    final entry = <UndoCell>[_snapshotCell(index)];
    for (final idx in peerIndexesOf(index)) {
      final cellNotes = notes[idx];
      if (cellNotes != null && cellNotes.contains(value)) {
        entry.add(_snapshotCell(idx));
      }
    }
    return entry;
  }

  List<UndoEntry> _appendUndo(UndoEntry entry) {
    final stack = List<UndoEntry>.of(undoStack)..add(entry);
    return stack.length > _undoStackCap
        ? stack.sublist(stack.length - _undoStackCap)
        : stack;
  }

  Map<int, Set<int>> _removeNotesAt(Map<int, Set<int>> source, int index) {
    if (!source.containsKey(index)) return source;
    return Map<int, Set<int>>.of(source)..remove(index);
  }

  Map<int, Set<int>> _autoCleanNotes(
    Map<int, Set<int>> source,
    int index,
    int value,
  ) {
    final result = Map<int, Set<int>>.of(source);
    var changed = false;

    void cleanAt(int idx) {
      final set = result[idx];
      if (set == null || !set.contains(value)) return;
      final newSet = Set<int>.of(set)..remove(value);
      if (newSet.isEmpty) {
        result.remove(idx);
      } else {
        result[idx] = newSet;
      }
      changed = true;
    }

    cleanAt(index);
    for (final idx in peerIndexesOf(index)) {
      cleanAt(idx);
    }
    return changed ? result : source;
  }
}
