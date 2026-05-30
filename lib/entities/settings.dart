// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sudoku/entities/type/theme_preference_enum.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

/// Préférences utilisateur. Immuable — toute modification passe par
/// `copyWith` (généré par freezed).
///
/// **Sérialisation** : `toJson()`/`fromJson()` générés. La version de schéma
/// est gérée par `entities/migrations/settings_migration.dart` — elle n'est pas
/// présente comme champ dans l'entité.
@freezed
abstract class Settings with _$Settings {
  const factory Settings({
    @Default(true) bool soundEnabled,
    @Default(true) bool hapticEnabled,
    @Default(ThemePreferenceEnum.system) ThemePreferenceEnum theme,
    @Default(ValidationModeEnum.autoCheck) ValidationModeEnum validationMode,
    @Default(true) bool hintButtonVisible,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);
}
