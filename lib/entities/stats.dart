// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sudoku/entities/_converters.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';

part 'stats.freezed.dart';
part 'stats.g.dart';

/// Stats d'une difficulté donnée — immuable.
@freezed
abstract class DifficultyStats with _$DifficultyStats {
  const DifficultyStats._();

  const factory DifficultyStats({
    @Default(0) int gamesSolved,
    @JsonKey(name: 'bestTimeMs')
    @_NullableDurationMsConverter()
    Duration? bestTime,
  }) = _DifficultyStats;

  factory DifficultyStats.fromJson(Map<String, dynamic> json) =>
      _$DifficultyStatsFromJson(json);

  /// Nouveau snapshot après une victoire. `bestTime` mis à jour seulement
  /// si meilleur que l'actuel.
  DifficultyStats withWin(Duration time) {
    final newBest = bestTime == null || time < bestTime!
        ? time
        : bestTime;
    return DifficultyStats(
      gamesSolved: gamesSolved + 1,
      bestTime: newBest,
    );
  }
}

/// Snapshot immuable de toutes les stats — une instance par chargement.
@freezed
abstract class Stats with _$Stats {
  const Stats._();

  const factory Stats({
    required Map<DifficultyEnum, DifficultyStats> byDifficulty,
  }) = _Stats;

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  factory Stats.empty() => Stats(
    byDifficulty: {
      for (final d in DifficultyEnum.values) d: const DifficultyStats(),
    },
  );

  DifficultyStats statsFor(DifficultyEnum d) =>
      byDifficulty[d] ?? const DifficultyStats();

  int get totalGamesSolved =>
      byDifficulty.values.fold(0, (sum, s) => sum + s.gamesSolved);

  Stats withWin(DifficultyEnum diff, Duration time) {
    final updated = Map<DifficultyEnum, DifficultyStats>.from(byDifficulty);
    updated[diff] =
        (byDifficulty[diff] ?? const DifficultyStats()).withWin(time);
    return Stats(byDifficulty: updated);
  }
}

/// Variante nullable de [DurationMsConverter] pour `bestTime`.
class _NullableDurationMsConverter implements JsonConverter<Duration?, int?> {
  const _NullableDurationMsConverter();
  @override
  Duration? fromJson(int? ms) {
    if (ms == null || ms < 0) return null;
    return Duration(milliseconds: ms);
  }

  @override
  int? toJson(Duration? d) => d?.inMilliseconds;
}
