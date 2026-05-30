import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/entities/game_session.dart';
import 'package:sudoku/entities/migrations/game_session_migration.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';

void main() {
  group('GameSession validation modes', () {
    test('auto-check reveals errors immediately', () {
      final session = _buildNearlyCompleteSession().applyValue(
        0,
        2,
        validationMode: ValidationModeEnum.autoCheck,
      );

      expect(session.hasVisibleError(0), isTrue);
      expect(session.errorCount, 1);
      expect(session.isComplete, isFalse);
    });

    test('auto-check completes validated numbers immediately', () {
      final session = _buildNearlyCompleteSession().applyValue(
        0,
        1,
        validationMode: ValidationModeEnum.autoCheck,
      );

      expect(session.isNumberCompleted(1), isTrue);
      expect(session.isComplete, isTrue);
    });

    test('validate mode waits for manual validation', () {
      var session = _buildNearlyCompleteSession().applyValue(
        0,
        1,
        validationMode: ValidationModeEnum.validate,
      );

      expect(session.isNumberCompleted(1), isFalse);
      expect(session.isComplete, isFalse);

      session = session.validateBoard();

      expect(session.isNumberCompleted(1), isTrue);
      expect(session.isComplete, isTrue);
    });

    test('validate mode reveals errors only after manual validation', () {
      var session = _buildNearlyCompleteSession().applyValue(
        0,
        2,
        validationMode: ValidationModeEnum.validate,
      );

      expect(session.hasVisibleError(0), isFalse);
      expect(session.errorCount, 0);

      session = session.validateBoard();

      expect(session.hasVisibleError(0), isTrue);
      expect(session.errorCount, 1);
    });

    test('no-check validates automatically on a full grid', () {
      final session = _buildNearlyCompleteSession().applyValue(
        0,
        2,
        validationMode: ValidationModeEnum.noCheck,
      );

      expect(session.hasVisibleError(0), isTrue);
      expect(session.errorCount, 1);
      expect(session.isComplete, isFalse);
    });

    test('no-check wins automatically when the full grid is correct', () {
      final session = _buildNearlyCompleteSession().applyValue(
        0,
        1,
        validationMode: ValidationModeEnum.noCheck,
      );

      expect(session.isNumberCompleted(1), isTrue);
      expect(session.isComplete, isTrue);
    });

    test('legacy v1 saves migrate and keep visible errors / validated cells', () {
      final raw = <String, dynamic>{
        'schemaVersion': 1,
        'difficulty': DifficultyEnum.easy.name,
        'solution': _solution,
        'userGrid': [2, ...List<int>.generate(79, (i) => _solution[i + 1]), 0],
        'givens': List<int>.generate(79, (i) => i + 1),
        'notes': <String, List<int>>{},
        'undoStack': <Object>[],
        'errorCount': 1,
        'hintsUsed': 0,
        'elapsedMs': 0,
      };

      final migrated = GameSessionMigration.migrate(raw);
      expect(migrated, isNotNull);

      final session = GameSession.fromJson(migrated!);
      expect(session.hasVisibleError(0), isTrue);
      expect(session.isNumberCompleted(2), isTrue);
    });

    test('unknown schema version is rejected by migration', () {
      final raw = <String, dynamic>{
        'schemaVersion': 99,
        'difficulty': DifficultyEnum.easy.name,
      };
      expect(GameSessionMigration.migrate(raw), isNull);
    });
  });

  group('GameSession immutability', () {
    test('applyValue returns this when no change', () {
      final base = _buildNearlyCompleteSession();
      // case déjà à 0, on remet 0 → no-op
      final same = base.applyValue(
        0,
        0,
        validationMode: ValidationModeEnum.noCheck,
      );
      expect(identical(same, base), isTrue);
    });

    test('applyValue returns a new instance on change', () {
      final base = _buildNearlyCompleteSession();
      final next = base.applyValue(
        0,
        2,
        validationMode: ValidationModeEnum.noCheck,
      );
      expect(identical(next, base), isFalse);
      // L'instance d'origine est intacte.
      expect(base.userGrid[0], 0);
      expect(next.userGrid[0], 2);
    });

    test('undo restores the previous state', () {
      final base = _buildNearlyCompleteSession();
      final after = base.applyValue(
        0,
        2,
        validationMode: ValidationModeEnum.autoCheck,
      );
      final undone = after.undo();
      expect(undone.userGrid[0], 0);
      expect(undone.hasVisibleError(0), isFalse);
      // anti-triche : errorCount n'est pas décrémenté
      expect(undone.errorCount, after.errorCount);
    });
  });
}

GameSession _buildNearlyCompleteSession() {
  return GameSession.fromGenerated(
    difficulty: DifficultyEnum.easy,
    solution: _solution,
    givens: List<int>.generate(80, (i) => i + 1),
  );
}

final _solution = [for (final row in _solutionGrid) ...row];

const _solutionGrid = [
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
  [4, 5, 6, 7, 8, 9, 1, 2, 3],
  [7, 8, 9, 1, 2, 3, 4, 5, 6],
  [2, 3, 4, 5, 6, 7, 8, 9, 1],
  [5, 6, 7, 8, 9, 1, 2, 3, 4],
  [8, 9, 1, 2, 3, 4, 5, 6, 7],
  [3, 4, 5, 6, 7, 8, 9, 1, 2],
  [6, 7, 8, 9, 1, 2, 3, 4, 5],
  [9, 1, 2, 3, 4, 5, 6, 7, 8],
];
