import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/entities/achievement.dart';
import 'package:sudoku/entities/type/achievement_id.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/utils/daily_challenge.dart';

void main() {
  group('Achievements — catalogue & seuils (#3)', () {
    test('un seuil de victoire rapide par difficulté', () {
      expect(kFastWinThresholds[DifficultyEnum.easy], const Duration(minutes: 10));
      expect(kFastWinThresholds[DifficultyEnum.medium], const Duration(minutes: 12));
      expect(kFastWinThresholds[DifficultyEnum.hard], const Duration(minutes: 15));
      expect(kFastWinThresholds[DifficultyEnum.expert], const Duration(minutes: 20));
    });

    test('mapping difficulté → succès rapide', () {
      expect(fastWinAchievementFor(DifficultyEnum.easy), AchievementId.fastEasy);
      expect(fastWinAchievementFor(DifficultyEnum.expert), AchievementId.fastExpert);
    });

    test('catalogue : paliers incrémentaux avec cible', () {
      AchievementDef defOf(AchievementId id) =>
          kAchievementCatalog.firstWhere((d) => d.id == id);
      expect(defOf(AchievementId.games10).target, 10);
      expect(defOf(AchievementId.games100).target, 100);
      expect(defOf(AchievementId.dailyStreak7).target, 7);
      expect(defOf(AchievementId.firstWin).isIncremental, isFalse);
    });
  });

  group('Daily — consécutivité des jours (série)', () {
    test('isNextDay vrai pour deux jours consécutifs', () {
      expect(isNextDay('2026-06-01', '2026-06-02'), isTrue);
      expect(isNextDay('2026-06-30', '2026-07-01'), isTrue);
    });

    test('isNextDay faux sinon', () {
      expect(isNextDay('2026-06-01', '2026-06-01'), isFalse);
      expect(isNextDay('2026-06-01', '2026-06-03'), isFalse);
      expect(isNextDay('oops', '2026-06-02'), isFalse);
    });
  });
}
