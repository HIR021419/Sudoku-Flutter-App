import 'package:sudoku/entities/difficulty_enum.dart';

const int kStatsSchemaVersion = 1;

/// Stats d'une difficulté donnée.
class DifficultyStats {
  const DifficultyStats({this.gamesSolved = 0, this.bestTime});

  final int gamesSolved;
  final Duration? bestTime;

  /// Retourne un nouveau DifficultyStats avec un nouveau win enregistré.
  /// `bestTime` est mis à jour seulement si meilleur que l'actuel.
  DifficultyStats withWin(Duration time) {
    final newBest = bestTime == null || time < bestTime!
        ? time
        : bestTime;
    return DifficultyStats(
      gamesSolved: gamesSolved + 1,
      bestTime: newBest,
    );
  }

  Map<String, dynamic> toJson() => {
        'gamesSolved': gamesSolved,
        'bestTimeMs': bestTime?.inMilliseconds,
      };

  factory DifficultyStats.fromJson(Map<String, dynamic> json) {
    final games = (json['gamesSolved'] as num?)?.toInt() ?? 0;
    final bestMs = (json['bestTimeMs'] as num?)?.toInt();
    return DifficultyStats(
      gamesSolved: games < 0 ? 0 : games,
      bestTime: bestMs != null && bestMs >= 0
          ? Duration(milliseconds: bestMs)
          : null,
    );
  }
}

/// Snapshot immuable de toutes les stats. Une instance par chargement.
class Stats {
  const Stats({required this.byDifficulty});

  final Map<DifficultyEnum, DifficultyStats> byDifficulty;

  factory Stats.empty() => Stats(byDifficulty: {
        for (final d in DifficultyEnum.values) d: const DifficultyStats(),
      });

  DifficultyStats statsFor(DifficultyEnum d) =>
      byDifficulty[d] ?? const DifficultyStats();

  int get totalGamesSolved =>
      byDifficulty.values.fold(0, (sum, s) => sum + s.gamesSolved);

  Stats withWin(DifficultyEnum diff, Duration time) {
    final updated = Map<DifficultyEnum, DifficultyStats>.from(byDifficulty);
    updated[diff] = (byDifficulty[diff] ?? const DifficultyStats()).withWin(time);
    return Stats(byDifficulty: updated);
  }

  Map<String, dynamic> toJson() => {
        'schemaVersion': kStatsSchemaVersion,
        'byDifficulty': {
          for (final entry in byDifficulty.entries)
            entry.key.name: entry.value.toJson(),
        },
      };

  /// Restaure les stats depuis un JSON. Retourne `Stats.empty()` si JSON invalide
  /// ou schéma incompatible — pas de perte critique, on accepte les défauts.
  factory Stats.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Stats.empty();
    final version = (json['schemaVersion'] as num?)?.toInt();
    if (version != kStatsSchemaVersion) return Stats.empty();

    final result = <DifficultyEnum, DifficultyStats>{};
    final raw = json['byDifficulty'];
    if (raw is Map) {
      for (final entry in raw.entries) {
        final name = entry.key;
        if (name is! String) continue;
        final diff = DifficultyEnum.values
            .where((d) => d.name == name)
            .firstOrNull;
        final value = entry.value;
        if (diff != null && value is Map<String, dynamic>) {
          try {
            result[diff] = DifficultyStats.fromJson(value);
          } catch (_) {
            // skip cette difficulté, accept default
          }
        }
      }
    }
    for (final d in DifficultyEnum.values) {
      result.putIfAbsent(d, () => const DifficultyStats());
    }
    return Stats(byDifficulty: result);
  }
}
