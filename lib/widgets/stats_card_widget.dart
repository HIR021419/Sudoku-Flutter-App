import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/l10n/difficulty_l10n.dart';
import 'package:sudoku/entities/stats.dart';
import 'package:sudoku/controllers/stats_controller.dart';

class StatsCardWidget extends StatelessWidget {
  const StatsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final stats = context.watch<StatsController>().stats;

    return Material(
      color: colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bar_chart_rounded,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Text(
                  l10n.statsTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _DifficultyCell(
                    difficulty: DifficultyEnum.easy,
                    stats: stats.statsFor(DifficultyEnum.easy),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _DifficultyCell(
                    difficulty: DifficultyEnum.medium,
                    stats: stats.statsFor(DifficultyEnum.medium),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _DifficultyCell(
                    difficulty: DifficultyEnum.hard,
                    stats: stats.statsFor(DifficultyEnum.hard),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _DifficultyCell(
                    difficulty: DifficultyEnum.expert,
                    stats: stats.statsFor(DifficultyEnum.expert),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyCell extends StatelessWidget {
  const _DifficultyCell({required this.difficulty, required this.stats});

  final DifficultyEnum difficulty;
  final DifficultyStats stats;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final bestTime = stats.bestTime;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            difficulty.localizedLabel(context),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.statsGamesSolved(stats.gamesSolved),
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                size: 12,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 3),
              Text(
                bestTime != null
                    ? _formatDuration(bestTime)
                    : l10n.statsNoRecord,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: bestTime != null
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    final mm = m.toString().padLeft(2, '0');
    final ss = s.toString().padLeft(2, '0');
    if (h > 0) return '${h.toString().padLeft(2, '0')}:$mm:$ss';
    return '$mm:$ss';
  }
}
