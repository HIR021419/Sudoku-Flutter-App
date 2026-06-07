// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sudoku/entities/_converters.dart';

part 'daily_record.freezed.dart';
part 'daily_record.g.dart';

/// Issue d'une tentative de défi du jour.
/// Règle (#1) : verrou posé **uniquement** après victoire ([won]) ou abandon
/// explicite ([abandoned]).
enum DailyOutcome { abandoned, won }

/// Résultat de la tentative de défi du jour pour une date donnée. Immuable.
@freezed
abstract class DailyRecord with _$DailyRecord {
  const DailyRecord._();

  const factory DailyRecord({
    /// Clé `yyyy-MM-dd` (UTC) — cf. `dailyDateKey`.
    required String dateKey,
    required DailyOutcome outcome,

    /// Temps effectif (brut + pénalités) — non nul uniquement si victoire.
    @JsonKey(name: 'effectiveMs')
    @NullableDurationMsConverter()
    Duration? effectiveTime,
    @Default(0) int errorCount,
    @Default(0) int hintsUsed,
  }) = _DailyRecord;

  factory DailyRecord.fromJson(Map<String, dynamic> json) =>
      _$DailyRecordFromJson(json);

  bool get isWon => outcome == DailyOutcome.won;
}
