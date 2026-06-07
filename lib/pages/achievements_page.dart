import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/controllers/achievements_notifier.dart';
import 'package:sudoku/controllers/stats_notifier.dart';
import 'package:sudoku/entities/achievement.dart';
import 'package:sudoku/entities/type/achievement_id.dart';
import 'package:sudoku/l10n/achievement_l10n.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/utils/scroll_behaviors.dart';

class AchievementsPage extends ConsumerWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final achievements = ref.watch(achievementsProvider).valueOrNull;
    final stats = ref.watch(statsNotifierProvider).valueOrNull;
    final totalSolved = stats?.totalGamesSolved ?? 0;
    final streak = achievements?.dailyStreak ?? 0;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.achievementsTitle)),
      body: ScrollConfiguration(
        behavior: const NoScrollbarBehavior(),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: kAchievementCatalog.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final def = kAchievementCatalog[i];
            final unlocked = achievements?.isUnlocked(def.id) ?? false;
            return _AchievementTile(
              def: def,
              unlocked: unlocked,
              progress: _progressFor(def, totalSolved, streak),
            );
          },
        ),
      ),
    );
  }

  /// Progression (current, target) pour un succès incrémental, sinon null.
  (int, int)? _progressFor(AchievementDef def, int totalSolved, int streak) {
    if (!def.isIncremental) return null;
    final target = def.target!;
    final current = switch (def.id) {
      AchievementId.dailyStreak7 => streak,
      _ => totalSolved, // games10/50/100
    };
    return (current.clamp(0, target), target);
  }
}

class _AchievementTile extends StatelessWidget {
  const _AchievementTile({
    required this.def,
    required this.unlocked,
    required this.progress,
  });

  final AchievementDef def;
  final bool unlocked;
  final (int, int)? progress;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fg = unlocked ? cs.onSurface : cs.onSurface.withValues(alpha: 0.45);

    return Opacity(
      opacity: unlocked ? 1 : 0.75,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: unlocked ? cs.primaryContainer : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: unlocked
                    ? cs.primary
                    : cs.onSurface.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                unlocked ? def.icon : Icons.lock_outline_rounded,
                color: unlocked ? cs.onPrimary : fg,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    def.id.localizedTitle(context),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: fg,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    def.id.localizedDescription(context),
                    style: TextStyle(
                      fontSize: 13,
                      color: fg.withValues(alpha: 0.85),
                    ),
                  ),
                  if (progress != null && !unlocked) ...[
                    const SizedBox(height: 8),
                    _ProgressBar(current: progress!.$1, target: progress!.$2),
                  ],
                ],
              ),
            ),
            if (unlocked)
              Icon(Icons.check_circle_rounded, color: cs.primary, size: 22),
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.current, required this.target});

  final int current;
  final int target;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: target == 0 ? 0 : current / target,
            minHeight: 6,
            backgroundColor: cs.onSurface.withValues(alpha: 0.12),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$current / $target',
          style: TextStyle(
            fontSize: 11,
            color: cs.onSurface.withValues(alpha: 0.6),
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
