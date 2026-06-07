import 'package:flutter/material.dart';
import 'package:sudoku/entities/type/achievement_id.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';

/// Métadonnées **statiques** d'un succès (catalogue). Les libellés sont
/// localisés ailleurs (cf. `achievement_l10n.dart`).
@immutable
class AchievementDef {
  const AchievementDef({
    required this.id,
    required this.icon,
    this.target,
  });

  final AchievementId id;
  final IconData icon;

  /// Cible pour un succès incrémental (paliers de parties, série daily) ;
  /// `null` pour un succès simple.
  final int? target;

  bool get isIncremental => target != null;
}

/// Catalogue ordonné des succès, pour l'affichage.
const List<AchievementDef> kAchievementCatalog = [
  AchievementDef(id: AchievementId.firstWin, icon: Icons.flag_rounded),
  AchievementDef(id: AchievementId.noMistake, icon: Icons.verified_rounded),
  AchievementDef(id: AchievementId.noHint, icon: Icons.psychology_rounded),
  AchievementDef(id: AchievementId.games10, icon: Icons.looks_one_rounded, target: 10),
  AchievementDef(id: AchievementId.games50, icon: Icons.looks_5_rounded, target: 50),
  AchievementDef(id: AchievementId.games100, icon: Icons.workspace_premium_rounded, target: 100),
  AchievementDef(id: AchievementId.allDifficulties, icon: Icons.dashboard_customize_rounded),
  AchievementDef(id: AchievementId.dailyFirst, icon: Icons.today_rounded),
  AchievementDef(id: AchievementId.dailyStreak7, icon: Icons.local_fire_department_rounded, target: 7),
  AchievementDef(id: AchievementId.fastEasy, icon: Icons.bolt_rounded),
  AchievementDef(id: AchievementId.fastMedium, icon: Icons.bolt_rounded),
  AchievementDef(id: AchievementId.fastHard, icon: Icons.bolt_rounded),
  AchievementDef(id: AchievementId.fastExpert, icon: Icons.bolt_rounded),
];

/// Seuils « victoire rapide » par difficulté (sur le **temps effectif**,
/// pénalités incluses).
const Map<DifficultyEnum, Duration> kFastWinThresholds = {
  DifficultyEnum.easy: Duration(minutes: 10),
  DifficultyEnum.medium: Duration(minutes: 12),
  DifficultyEnum.hard: Duration(minutes: 15),
  DifficultyEnum.expert: Duration(minutes: 20),
};

/// Succès « victoire rapide » correspondant à une difficulté.
AchievementId fastWinAchievementFor(DifficultyEnum d) => switch (d) {
  DifficultyEnum.easy => AchievementId.fastEasy,
  DifficultyEnum.medium => AchievementId.fastMedium,
  DifficultyEnum.hard => AchievementId.fastHard,
  DifficultyEnum.expert => AchievementId.fastExpert,
};
