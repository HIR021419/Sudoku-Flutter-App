import 'package:flutter/material.dart';

enum ThemePreference {
  system,
  light,
  dark;

  ThemeMode get themeMode => switch (this) {
        ThemePreference.system => ThemeMode.system,
        ThemePreference.light => ThemeMode.light,
        ThemePreference.dark => ThemeMode.dark,
      };
}

const int kSettingsSchemaVersion = 1;

class Settings {
  const Settings({
    this.soundEnabled = true,
    this.hapticEnabled = true,
    this.theme = ThemePreference.system,
  });

  final bool soundEnabled;
  final bool hapticEnabled;
  final ThemePreference theme;

  Settings copyWith({
    bool? soundEnabled,
    bool? hapticEnabled,
    ThemePreference? theme,
  }) {
    return Settings(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      hapticEnabled: hapticEnabled ?? this.hapticEnabled,
      theme: theme ?? this.theme,
    );
  }

  Map<String, dynamic> toJson() => {
        'schemaVersion': kSettingsSchemaVersion,
        'soundEnabled': soundEnabled,
        'hapticEnabled': hapticEnabled,
        'theme': theme.name,
      };

  factory Settings.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const Settings();
    final version = (json['schemaVersion'] as num?)?.toInt();
    if (version != kSettingsSchemaVersion) return const Settings();
    final themeName = json['theme'];
    final theme = themeName is String
        ? ThemePreference.values
            .where((t) => t.name == themeName)
            .firstOrNull
        : null;
    return Settings(
      soundEnabled: json['soundEnabled'] is bool
          ? json['soundEnabled'] as bool
          : true,
      hapticEnabled: json['hapticEnabled'] is bool
          ? json['hapticEnabled'] as bool
          : true,
      theme: theme ?? ThemePreference.system,
    );
  }
}
