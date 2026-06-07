// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievements_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AchievementsState _$AchievementsStateFromJson(Map<String, dynamic> json) =>
    _AchievementsState(
      unlocked:
          (json['unlocked'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$AchievementIdEnumMap, e))
              .toSet() ??
          const <AchievementId>{},
      dailyStreak: (json['dailyStreak'] as num?)?.toInt() ?? 0,
      lastDailyWinDateKey: json['lastDailyWinDateKey'] as String?,
    );

Map<String, dynamic> _$AchievementsStateToJson(
  _AchievementsState instance,
) => <String, dynamic>{
  'unlocked': instance.unlocked.map((e) => _$AchievementIdEnumMap[e]!).toList(),
  'dailyStreak': instance.dailyStreak,
  'lastDailyWinDateKey': instance.lastDailyWinDateKey,
};

const _$AchievementIdEnumMap = {
  AchievementId.firstWin: 'firstWin',
  AchievementId.noMistake: 'noMistake',
  AchievementId.noHint: 'noHint',
  AchievementId.games10: 'games10',
  AchievementId.games50: 'games50',
  AchievementId.games100: 'games100',
  AchievementId.allDifficulties: 'allDifficulties',
  AchievementId.dailyFirst: 'dailyFirst',
  AchievementId.dailyStreak7: 'dailyStreak7',
  AchievementId.fastEasy: 'fastEasy',
  AchievementId.fastMedium: 'fastMedium',
  AchievementId.fastHard: 'fastHard',
  AchievementId.fastExpert: 'fastExpert',
};
