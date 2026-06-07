/// Identifiants stables des succès (#3). **Ne pas renommer** : les `.name`
/// servent de clés de persistance (et, en Phase 5, de mapping vers les IDs
/// Play Games Services).
enum AchievementId {
  firstWin,
  noMistake,
  noHint,
  games10,
  games50,
  games100,
  allDifficulties,
  dailyFirst,
  dailyStreak7,
  fastEasy,
  fastMedium,
  fastHard,
  fastExpert;

  static AchievementId? tryParse(String? raw) {
    if (raw == null) return null;
    for (final a in AchievementId.values) {
      if (a.name == raw) return a;
    }
    return null;
  }
}
