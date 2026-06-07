import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/entities/daily_record.dart';
import 'package:sudoku/providers/repositories.dart';
import 'package:sudoku/utils/daily_challenge.dart';

part 'daily_notifier.freezed.dart';
part 'daily_notifier.g.dart';

/// État du défi du jour pour l'UI.
///
/// [record] n'est renseigné que s'il concerne **aujourd'hui** ([todayKey]) ;
/// sinon le défi n'a pas encore été verrouillé aujourd'hui.
@freezed
abstract class DailyState with _$DailyState {
  const DailyState._();

  const factory DailyState({required String todayKey, DailyRecord? record}) =
      _DailyState;

  bool get playedToday => record != null;
  bool get wonToday => record?.isWon ?? false;
}

/// Défi du jour (#1). Verrou posé **uniquement** après victoire ou abandon
/// explicite. `keepAlive` pour conserver l'état pendant la navigation
/// home → grille → home.
@Riverpod(keepAlive: true)
class DailyChallenge extends _$DailyChallenge {
  @override
  Future<DailyState> build() async {
    final repo = ref.read(dailyRepositoryProvider);
    final todayKey = dailyDateKey(DateTime.now());
    final json = await repo.load();
    DailyRecord? record;
    if (json != null) {
      try {
        final parsed = DailyRecord.fromJson(json);
        // On n'expose le record que s'il correspond à aujourd'hui.
        if (parsed.dateKey == todayKey) record = parsed;
      } catch (_) {
        // Blob corrompu : ignoré (défi considéré comme non joué).
      }
    }
    return DailyState(todayKey: todayKey, record: record);
  }

  /// Verrouille le défi du jour après un **abandon explicite**.
  /// No-op si déjà verrouillé aujourd'hui.
  Future<void> recordAbandon() async {
    final st = state.valueOrNull;
    if (st == null || st.playedToday) return;
    await _persist(
      st,
      DailyRecord(dateKey: st.todayKey, outcome: DailyOutcome.abandoned),
    );
  }

  /// Enregistre la victoire du jour avec le temps effectif (verrou).
  Future<void> recordWin(
    Duration effectiveTime, {
    required int errorCount,
    required int hintsUsed,
  }) async {
    final st = state.valueOrNull;
    if (st == null) return;
    await _persist(
      st,
      DailyRecord(
        dateKey: st.todayKey,
        outcome: DailyOutcome.won,
        effectiveTime: effectiveTime,
        errorCount: errorCount,
        hintsUsed: hintsUsed,
      ),
    );
  }

  Future<void> _persist(DailyState st, DailyRecord rec) async {
    state = AsyncData(DailyState(todayKey: st.todayKey, record: rec));
    try {
      await ref.read(dailyRepositoryProvider).save(rec.toJson());
    } catch (e, s) {
      debugPrint('DailyChallenge persist failed: $e\n$s');
    }
  }
}
