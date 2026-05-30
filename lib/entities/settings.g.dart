// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
  soundEnabled: json['soundEnabled'] as bool? ?? true,
  hapticEnabled: json['hapticEnabled'] as bool? ?? true,
  theme:
      $enumDecodeNullable(_$ThemePreferenceEnumEnumMap, json['theme']) ??
      ThemePreferenceEnum.system,
  validationMode:
      $enumDecodeNullable(
        _$ValidationModeEnumEnumMap,
        json['validationMode'],
      ) ??
      ValidationModeEnum.autoCheck,
  hintButtonVisible: json['hintButtonVisible'] as bool? ?? true,
);

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
  'soundEnabled': instance.soundEnabled,
  'hapticEnabled': instance.hapticEnabled,
  'theme': _$ThemePreferenceEnumEnumMap[instance.theme]!,
  'validationMode': _$ValidationModeEnumEnumMap[instance.validationMode]!,
  'hintButtonVisible': instance.hintButtonVisible,
};

const _$ThemePreferenceEnumEnumMap = {
  ThemePreferenceEnum.system: 'system',
  ThemePreferenceEnum.light: 'light',
  ThemePreferenceEnum.dark: 'dark',
};

const _$ValidationModeEnumEnumMap = {
  ValidationModeEnum.autoCheck: 'autoCheck',
  ValidationModeEnum.validate: 'validate',
  ValidationModeEnum.noCheck: 'noCheck',
};
