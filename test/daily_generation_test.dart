import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/utils/daily_challenge.dart';
import 'package:sudoku/utils/sudoku_utils.dart';

void main() {
  group('Daily — génération déterministe (#1)', () {
    test('même seed → même grille (solution + givens)', () {
      final a = generateSeededPuzzleData((DifficultyEnum.medium, 20260601));
      final b = generateSeededPuzzleData((DifficultyEnum.medium, 20260601));
      expect(a.solution, equals(b.solution));
      expect(a.givens, equals(b.givens));
    });

    test('seeds différentes → grilles différentes', () {
      final a = generateSeededPuzzleData((DifficultyEnum.medium, 20260601));
      final b = generateSeededPuzzleData((DifficultyEnum.medium, 20260602));
      expect(a.solution, isNot(equals(b.solution)));
    });
  });

  group('Daily — clé de jour et seed (UTC)', () {
    test('dailyDateKey est en UTC au format yyyy-MM-dd', () {
      // 2026-06-01 01:30 UTC+2 → 2026-05-31 23:30 UTC.
      final local = DateTime.utc(2026, 5, 31, 23, 30);
      expect(dailyDateKey(local), '2026-05-31');
    });

    test('dailySeed dérive de la date UTC', () {
      expect(dailySeed(DateTime.utc(2026, 6, 1)), 20260601);
    });
  });
}
