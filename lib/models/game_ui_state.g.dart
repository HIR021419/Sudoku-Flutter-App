// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_ui_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameUiState _$GameUiStateFromJson(Map<String, dynamic> json) => _GameUiState(
  notesMode: json['notesMode'] as bool? ?? false,
  fillMode: json['fillMode'] as bool? ?? false,
  activeNumber: (json['activeNumber'] as num?)?.toInt(),
);

Map<String, dynamic> _$GameUiStateToJson(_GameUiState instance) =>
    <String, dynamic>{
      'notesMode': instance.notesMode,
      'fillMode': instance.fillMode,
      'activeNumber': instance.activeNumber,
    };
