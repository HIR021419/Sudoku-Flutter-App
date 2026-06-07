import 'package:sudoku/entities/type/achievement_id.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';

/// IDs Google Play Games Services (#2).
///
/// ⚠️ **Placeholders** : à remplacer par les IDs réels créés dans la Play
/// Console (Jeux > Classements / Succès). Format Android typique :
/// `CgkIxxxxxxxxxxEAQAQ`.
///
/// Tant qu'un ID commence par `TODO_`, l'appel PGS correspondant est ignoré
/// silencieusement (cf. [isPlaceholder]) — l'app fonctionne sans config.
///
/// Les leaderboards doivent être créés en **« smaller is better »** : on
/// soumet le **temps effectif en millisecondes** (plus petit = meilleur).
class PlayGamesConfig {
  const PlayGamesConfig._();

  static const Map<DifficultyEnum, String> leaderboardByDifficulty = {
    DifficultyEnum.easy: 'CgkIodHYuZ4XEAIQAQ',
    DifficultyEnum.medium: 'CgkIodHYuZ4XEAIQAg',
    DifficultyEnum.hard: 'CgkIodHYuZ4XEAIQAw',
    DifficultyEnum.expert: 'CgkIodHYuZ4XEAIQBA',
  };

  /// Leaderboard du défi du jour (onglet « Aujourd'hui » pour le rang du jour).
  static const String dailyLeaderboard = 'CgkIodHYuZ4XEAIQEg';

  static const Map<AchievementId, String> achievementIds = {
    AchievementId.firstWin: 'CgkIodHYuZ4XEAIQBQ',
    AchievementId.noMistake: 'CgkIodHYuZ4XEAIQBg',
    AchievementId.noHint: 'CgkIodHYuZ4XEAIQBw',
    AchievementId.games10: 'CgkIodHYuZ4XEAIQCA',
    AchievementId.games50: 'CgkIodHYuZ4XEAIQCQ',
    AchievementId.games100: 'CgkIodHYuZ4XEAIQCg',
    AchievementId.allDifficulties: 'CgkIodHYuZ4XEAIQDA',
    AchievementId.dailyFirst: 'CgkIodHYuZ4XEAIQCw',
    AchievementId.dailyStreak7: 'CgkIodHYuZ4XEAIQDQ',
    AchievementId.fastEasy: 'CgkIodHYuZ4XEAIQDg',
    AchievementId.fastMedium: 'CgkIodHYuZ4XEAIQDw',
    AchievementId.fastHard: 'CgkIodHYuZ4XEAIQEA',
    AchievementId.fastExpert: 'CgkIodHYuZ4XEAIQEQ',
  };

  /// Vrai tant que l'ID n'a pas été renseigné (reste un placeholder).
  static bool isPlaceholder(String? id) => id == null || id.startsWith('TODO_');
}
