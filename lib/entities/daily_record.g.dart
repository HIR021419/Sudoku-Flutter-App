// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyRecord _$DailyRecordFromJson(Map<String, dynamic> json) => _DailyRecord(
  dateKey: json['dateKey'] as String,
  outcome: $enumDecode(_$DailyOutcomeEnumMap, json['outcome']),
  effectiveTime: const NullableDurationMsConverter().fromJson(
    (json['effectiveMs'] as num?)?.toInt(),
  ),
  errorCount: (json['errorCount'] as num?)?.toInt() ?? 0,
  hintsUsed: (json['hintsUsed'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$DailyRecordToJson(_DailyRecord instance) =>
    <String, dynamic>{
      'dateKey': instance.dateKey,
      'outcome': _$DailyOutcomeEnumMap[instance.outcome]!,
      'effectiveMs': const NullableDurationMsConverter().toJson(
        instance.effectiveTime,
      ),
      'errorCount': instance.errorCount,
      'hintsUsed': instance.hintsUsed,
    };

const _$DailyOutcomeEnumMap = {
  DailyOutcome.abandoned: 'abandoned',
  DailyOutcome.won: 'won',
};
