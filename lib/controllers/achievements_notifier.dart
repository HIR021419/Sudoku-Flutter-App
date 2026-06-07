import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/controllers/stats_notifier.dart';
import 'package:sudoku/entities/achievement.dart';
import 'package:sudoku/entities/achievements_state.dart';
import 'package:sudoku/entities/type/achievement_id.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/providers/repositories.dart';
import 'package:sudoku/utils/daily_challenge.dart';

part 'achievements_notifier.g.dart';

/// Moteur de succès (#3). Source de vérité **locale** (fonctionne hors-ligne) ;
/// en Phase 5 (PGS), pousser les déblocages vers l'API Achievements.
///
/// Les méthodes `onGameWin`/`onDailyWin` retournent la liste des succès
/// **nouvellement** débloqués (pour le retour UI).
@Riverpod(keepAlive: true)
class Achievements extends _$Achievements {
  @override
  Future<AchievementsState> build() async {
    final repo = ref.read(achievementsRepositoryProvider);
    final json = await repo.load();
    if (json == null) return const AchievementsState();
    try {
      return AchievementsState.fromJson(json);
    } catch (_) {
      return const AchievementsState();
    }
  }

  /// À appeler **après** `StatsNotifier.recordWin` (les paliers lisent les
  /// stats déjà à jour).
  Future<List<AchievementId>> onGameWin({
    required DifficultyEnum difficulty,
    required Duration effectiveTime,
    required int errorCount,
    required int hintsUsed,
  }) async {
    final st = state.valueOrNull;
    if (st == null) return const [];

    final newly = <AchievementId>{};
    void unlock(AchievementId id) {
      if (!st.unlocked.contains(id)) newly.add(id);
    }

    unlock(AchievementId.firstWin);
    if (errorCount == 0) unlock(AchievementId.noMistake);
    if (hintsUsed == 0) unlock(AchievementId.noHint);

    final threshold = kFastWinThresholds[difficulty];
    if (threshold != null && effectiveTime < threshold) {
      unlock(fastWinAchievementFor(difficulty));
    }

    // Paliers de parties + toutes difficultés : dérivés des Stats globales,
    // qui viennent d'être mises à jour par recordWin.
    final stats = ref.read(statsNotifierProvider).valueOrNull;
    if (stats != null) {
      final total = stats.totalGamesSolved;
      if (total >= 10) unlock(AchievementId.games10);
      if (total >= 50) unlock(AchievementId.games50);
      if (total >= 100) unlock(AchievementId.games100);
      final allDiff = DifficultyEnum.values.every(
        (d) => stats.statsFor(d).gamesSolved > 0,
      );
      if (allDiff) unlock(AchievementId.allDifficulties);
    }

    if (newly.isEmpty) return const [];
    await _persist(st.copyWith(unlocked: {...st.unlocked, ...newly}));
    return newly.toList();
  }

  /// À appeler après une victoire au défi du jour.
  Future<List<AchievementId>> onDailyWin({required String dateKey}) async {
    final st = state.valueOrNull;
    if (st == null) return const [];

    final newly = <AchievementId>{};
    void unlock(AchievementId id) {
      if (!st.unlocked.contains(id)) newly.add(id);
    }

    unlock(AchievementId.dailyFirst);

    final prev = st.lastDailyWinDateKey;
    final int streak;
    if (prev == dateKey) {
      streak = st.dailyStreak == 0 ? 1 : st.dailyStreak; // garde-fou même jour
    } else if (prev != null && isNextDay(prev, dateKey)) {
      streak = st.dailyStreak + 1;
    } else {
      streak = 1;
    }
    if (streak >= 7) unlock(AchievementId.dailyStreak7);

    await _persist(
      st.copyWith(
        unlocked: {...st.unlocked, ...newly},
        dailyStreak: streak,
        lastDailyWinDateKey: dateKey,
      ),
    );
    return newly.toList();
  }

  Future<void> _persist(AchievementsState next) async {
    state = AsyncData(next);
    try {
      await ref.read(achievementsRepositoryProvider).save(next.toJson());
    } catch (e, s) {
      debugPrint('Achievements persist failed: $e\n$s');
    }
  }
}
