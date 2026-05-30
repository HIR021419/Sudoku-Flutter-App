// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DifficultyStats _$DifficultyStatsFromJson(Map<String, dynamic> json) =>
    _DifficultyStats(
      gamesSolved: (json['gamesSolved'] as num?)?.toInt() ?? 0,
      bestTime: const _NullableDurationMsConverter().fromJson(
        (json['bestTimeMs'] as num?)?.toInt(),
      ),
    );

Map<String, dynamic> _$DifficultyStatsToJson(
  _DifficultyStats instance,
) => <String, dynamic>{
  'gamesSolved': instance.gamesSolved,
  'bestTimeMs': const _NullableDurationMsConverter().toJson(instance.bestTime),
};

_Stats _$StatsFromJson(Map<String, dynamic> json) => _Stats(
  byDifficulty: (json['byDifficulty'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      $enumDecode(_$DifficultyEnumEnumMap, k),
      DifficultyStats.fromJson(e as Map<String, dynamic>),
    ),
  ),
);

Map<String, dynamic> _$StatsToJson(_Stats instance) => <String, dynamic>{
  'byDifficulty': instance.byDifficulty.map(
    (k, e) => MapEntry(_$DifficultyEnumEnumMap[k]!, e),
  ),
};

const _$DifficultyEnumEnumMap = {
  DifficultyEnum.easy: 'easy',
  DifficultyEnum.medium: 'medium',
  DifficultyEnum.hard: 'hard',
  DifficultyEnum.expert: 'expert',
};
