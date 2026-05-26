// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'undo_cell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UndoCell _$UndoCellFromJson(Map<String, dynamic> json) => UndoCell(
  index: (json['i'] as num).toInt(),
  value: (json['v'] as num).toInt(),
  notes: UndoCell._notesFromJson(json['n'] as List),
  hasVisibleError: json['e'] as bool,
  isValidatedCorrect: json['ok'] as bool,
);

Map<String, dynamic> _$UndoCellToJson(UndoCell instance) => <String, dynamic>{
  'i': instance.index,
  'v': instance.value,
  'n': UndoCell._notesToJson(instance.notes),
  'e': instance.hasVisibleError,
  'ok': instance.isValidatedCorrect,
};
