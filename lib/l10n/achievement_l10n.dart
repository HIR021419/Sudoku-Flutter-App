import 'package:flutter/widgets.dart';
import 'package:sudoku/entities/type/achievement_id.dart';
import 'package:sudoku/l10n/app_localizations.dart';

/// Libellés localisés des succès. Centralise le mapping id → chaînes l10n,
/// pour éviter de l'éparpiller dans l'UI.
extension AchievementL10n on AchievementId {
  String localizedTitle(BuildContext context) {
    final l = AppLocalizations.of(context);
    return switch (this) {
      AchievementId.firstWin => l.achFirstWinTitle,
      AchievementId.noMistake => l.achNoMistakeTitle,
      AchievementId.noHint => l.achNoHintTitle,
      AchievementId.games10 => l.achGames10Title,
      AchievementId.games50 => l.achGames50Title,
      AchievementId.games100 => l.achGames100Title,
      AchievementId.allDifficulties => l.achAllDifficultiesTitle,
      AchievementId.dailyFirst => l.achDailyFirstTitle,
      AchievementId.dailyStreak7 => l.achDailyStreak7Title,
      AchievementId.fastEasy => l.achFastEasyTitle,
      AchievementId.fastMedium => l.achFastMediumTitle,
      AchievementId.fastHard => l.achFastHardTitle,
      AchievementId.fastExpert => l.achFastExpertTitle,
    };
  }

  String localizedDescription(BuildContext context) {
    final l = AppLocalizations.of(context);
    return switch (this) {
      AchievementId.firstWin => l.achFirstWinDesc,
      AchievementId.noMistake => l.achNoMistakeDesc,
      AchievementId.noHint => l.achNoHintDesc,
      AchievementId.games10 => l.achGames10Desc,
      AchievementId.games50 => l.achGames50Desc,
      AchievementId.games100 => l.achGames100Desc,
      AchievementId.allDifficulties => l.achAllDifficultiesDesc,
      AchievementId.dailyFirst => l.achDailyFirstDesc,
      AchievementId.dailyStreak7 => l.achDailyStreak7Desc,
      AchievementId.fastEasy => l.achFastEasyDesc,
      AchievementId.fastMedium => l.achFastMediumDesc,
      AchievementId.fastHard => l.achFastHardDesc,
      AchievementId.fastExpert => l.achFastExpertDesc,
    };
  }
}
