// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'undo_cell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UndoCell _$UndoCellFromJson(Map<String, dynamic> json) => _UndoCell(
  index: (json['i'] as num).toInt(),
  value: (json['v'] as num).toInt(),
  notes: const IntSetConverter().fromJson(json['n'] as List),
  hasVisibleError: json['e'] as bool,
  isValidatedCorrect: json['ok'] as bool,
);

Map<String, dynamic> _$UndoCellToJson(_UndoCell instance) => <String, dynamic>{
  'i': instance.index,
  'v': instance.value,
  'n': const IntSetConverter().toJson(instance.notes),
  'e': instance.hasVisibleError,
  'ok': instance.isValidatedCorrect,
};
