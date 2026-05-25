import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/entities/game_session.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';

void main() {
  group('GameSession validation modes', () {
    test('auto-check reveals errors immediately', () {
      final session = _buildNearlyCompleteSession();

      session.applyValue(0, 2, validationMode: ValidationModeEnum.autoCheck);

      expect(session.hasVisibleError(0), isTrue);
      expect(session.errorCount, 1);
      expect(session.isComplete, isFalse);
    });

    test('auto-check completes validated numbers immediately', () {
      final session = _buildNearlyCompleteSession();

      session.applyValue(0, 1, validationMode: ValidationModeEnum.autoCheck);

      expect(session.isNumberCompleted(1), isTrue);
      expect(session.isComplete, isTrue);
    });

    test('validate mode waits for manual validation', () {
      final session = _buildNearlyCompleteSession();

      session.applyValue(0, 1, validationMode: ValidationModeEnum.validate);

      expect(session.isNumberCompleted(1), isFalse);
      expect(session.isComplete, isFalse);

      session.validateBoard();

      expect(session.isNumberCompleted(1), isTrue);
      expect(session.isComplete, isTrue);
    });

    test('validate mode reveals errors only after manual validation', () {
      final session = _buildNearlyCompleteSession();

      session.applyValue(0, 2, validationMode: ValidationModeEnum.validate);

      expect(session.hasVisibleError(0), isFalse);
      expect(session.errorCount, 0);

      session.validateBoard();

      expect(session.hasVisibleError(0), isTrue);
      expect(session.errorCount, 1);
    });

    test('no-check validates automatically on a full grid', () {
      final session = _buildNearlyCompleteSession();

      session.applyValue(0, 2, validationMode: ValidationModeEnum.noCheck);

      expect(session.hasVisibleError(0), isTrue);
      expect(session.errorCount, 1);
      expect(session.isComplete, isFalse);
    });

    test('no-check wins automatically when the full grid is correct', () {
      final session = _buildNearlyCompleteSession();

      session.applyValue(0, 1, validationMode: ValidationModeEnum.noCheck);

      expect(session.isNumberCompleted(1), isTrue);
      expect(session.isComplete, isTrue);
    });

    test('legacy saves keep visible errors and validated cells on restore', () {
      final session = GameSession.fromJson({
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
      });

      expect(session, isNotNull);
      expect(session!.hasVisibleError(0), isTrue);
      expect(session.isNumberCompleted(2), isTrue);
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
