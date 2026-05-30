import 'package:sudoku/entities/_schema_versions.dart';

/// Migration du JSON persisté de [Stats] vers la version courante.
///
/// Stratégie **stricte** : sur version inconnue → retourne `null`. Le caller
/// (typiquement le `StatsNotifier`) retombe sur `Stats.empty()`.
class StatsMigration {
  const StatsMigration._();

  static Map<String, dynamic>? migrate(Map<String, dynamic> json) {
    final version = (json['schemaVersion'] as num?)?.toInt();
    return switch (version) {
      kStatsSchemaVersion => Map<String, dynamic>.from(json),
      _ => null,
    };
  }
}
