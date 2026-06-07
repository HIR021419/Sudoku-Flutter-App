import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/entities/_schema_versions.dart';
import 'package:sudoku/entities/migrations/stats_migration.dart';
import 'package:sudoku/entities/stats.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/providers/repositories.dart';

part 'stats_notifier.g.dart';

/// AsyncNotifier qui expose les [Stats] et gère leur persistance.
///
/// Stratégie de migration **stricte** : si le blob est inconnu/corrompu,
/// on retombe sur `Stats.empty()` (perte des stats acceptée).
@Riverpod(keepAlive: true)
class StatsNotifier extends _$StatsNotifier {
  @override
  Future<Stats> build() async {
    final repo = ref.read(statsRepositoryProvider);
    final json = await repo.load();
    return _hydrate(json);
  }

  Stats _hydrate(Map<String, dynamic>? json) {
    if (json == null) return Stats.empty();
    final migrated = StatsMigration.migrate(json);
    if (migrated == null) return Stats.empty();
    try {
      return Stats.fromJson(migrated);
    } catch (_) {
      return Stats.empty();
    }
  }

  /// Enregistre une victoire — met à jour gamesSolved et bestTime si meilleur.
  /// [time] est le **temps effectif** (brut + pénalités erreurs/indices, cf.
  /// `GameSession.effectiveTime`) : c'est lui qui fait foi pour le record.
  Future<void> recordWin(DifficultyEnum difficulty, Duration time) async {
    final current = state.valueOrNull ?? Stats.empty();
    final next = current.withWin(difficulty, time);
    state = AsyncData(next);
    try {
      await ref.read(statsRepositoryProvider).save({
        ...next.toJson(),
        'schemaVersion': kStatsSchemaVersion,
      });
    } catch (e, st) {
      debugPrint('StatsNotifier.recordWin save failed: $e\n$st');
    }
  }
}
