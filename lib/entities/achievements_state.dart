// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sudoku/entities/type/achievement_id.dart';

part 'achievements_state.freezed.dart';
part 'achievements_state.g.dart';

/// État persistant des succès (#3).
///
/// - [unlocked] : succès débloqués.
/// - [dailyStreak] / [lastDailyWinDateKey] : suivi de la série de défis du jour
///   (non dérivable des stats globales, donc stocké ici).
@freezed
abstract class AchievementsState with _$AchievementsState {
  const AchievementsState._();

  const factory AchievementsState({
    @Default(<AchievementId>{}) Set<AchievementId> unlocked,
    @Default(0) int dailyStreak,
    String? lastDailyWinDateKey,
  }) = _AchievementsState;

  factory AchievementsState.fromJson(Map<String, dynamic> json) =>
      _$AchievementsStateFromJson(json);

  bool isUnlocked(AchievementId id) => unlocked.contains(id);
}
