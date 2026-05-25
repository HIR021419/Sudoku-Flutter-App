import 'package:flutter/material.dart';

enum ThemePreferenceEnum {
  system,
  light,
  dark;

  ThemeMode get themeMode => switch (this) {
    ThemePreferenceEnum.system => ThemeMode.system,
    ThemePreferenceEnum.light => ThemeMode.light,
    ThemePreferenceEnum.dark => ThemeMode.dark,
  };
}
