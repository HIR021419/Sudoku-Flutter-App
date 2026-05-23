import 'package:flutter/widgets.dart';
import 'package:sudoku/entities/difficulty_enum.dart';
import 'package:sudoku/l10n/app_localizations.dart';

/// Extension qui retourne le label localisé d'une difficulté.
/// Le getter `difficulty.label` natif reste en français comme fallback
/// (utile pour la sérialisation et les tests).
extension DifficultyL10n on DifficultyEnum {
  String localizedLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case DifficultyEnum.easy:
        return l10n.difficultyEasy;
      case DifficultyEnum.medium:
        return l10n.difficultyMedium;
      case DifficultyEnum.hard:
        return l10n.difficultyHard;
      case DifficultyEnum.expert:
        return l10n.difficultyExpert;
    }
  }
}
