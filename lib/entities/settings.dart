import 'package:sudoku/entities/type/theme_preference_enum.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';

const int kSettingsSchemaVersion = 2;

class Settings {
  const Settings({
    this.soundEnabled = true,
    this.hapticEnabled = true,
    this.theme = ThemePreferenceEnum.system,
    this.validationMode = ValidationModeEnum.autoCheck,
  });

  final bool soundEnabled;
  final bool hapticEnabled;
  final ThemePreferenceEnum theme;
  final ValidationModeEnum validationMode;

  Settings copyWith({
    bool? soundEnabled,
    bool? hapticEnabled,
    ThemePreferenceEnum? theme,
    ValidationModeEnum? validationMode,
  }) {
    return Settings(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      hapticEnabled: hapticEnabled ?? this.hapticEnabled,
      theme: theme ?? this.theme,
      validationMode: validationMode ?? this.validationMode,
    );
  }

  Map<String, dynamic> toJson() => {
    'schemaVersion': kSettingsSchemaVersion,
    'soundEnabled': soundEnabled,
    'hapticEnabled': hapticEnabled,
    'theme': theme.name,
    'validationMode': validationMode.name,
  };

  factory Settings.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const Settings();
    final version = (json['schemaVersion'] as num?)?.toInt();
    if (version != 1 && version != kSettingsSchemaVersion) {
      return const Settings();
    }
    final themeName = json['theme'];
    final theme = themeName is String
        ? ThemePreferenceEnum.values.where((t) => t.name == themeName).firstOrNull
        : null;
    final validationModeName = json['validationMode'];
    final validationMode = validationModeName is String
        ? ValidationModeEnum.values
              .where((mode) => mode.name == validationModeName)
              .firstOrNull
        : null;
    return Settings(
      soundEnabled: json['soundEnabled'] is bool
          ? json['soundEnabled'] as bool
          : true,
      hapticEnabled: json['hapticEnabled'] is bool
          ? json['hapticEnabled'] as bool
          : true,
      theme: theme ?? ThemePreferenceEnum.system,
      validationMode: validationMode ?? ValidationModeEnum.autoCheck,
    );
  }
}
