import 'package:sudoku/entities/_schema_versions.dart';

/// Migration du JSON persisté de [Settings] vers la version courante.
///
/// Stratégie **stricte** : sur version inconnue → retourne `null`. Le caller
/// (typiquement le `SettingsNotifier`) retombe sur `const Settings()`.
class SettingsMigration {
  const SettingsMigration._();

  static Map<String, dynamic>? migrate(Map<String, dynamic> json) {
    final version = (json['schemaVersion'] as num?)?.toInt();
    return switch (version) {
      1 => _v1ToV3(json),
      2 => _v2ToV3(json),
      kSettingsSchemaVersion => Map<String, dynamic>.from(json),
      _ => null,
    };
  }

  /// v1 → v3 : chaîne via v2 puis v3.
  static Map<String, dynamic> _v1ToV3(Map<String, dynamic> json) =>
      _v2ToV3(_v1ToV2(json));

  /// v1 → v2 : pas de changement de format, ce stub formalise la chaîne.
  static Map<String, dynamic> _v1ToV2(Map<String, dynamic> json) => {
    ...json,
    'schemaVersion': 2,
  };

  /// v2 → v3 : ajout du champ `hintButtonVisible` avec valeur par défaut `true`.
  static Map<String, dynamic> _v2ToV3(Map<String, dynamic> json) => {
    ...json,
    'schemaVersion': kSettingsSchemaVersion,
    'hintButtonVisible': json['hintButtonVisible'] ?? true,
  };
}
