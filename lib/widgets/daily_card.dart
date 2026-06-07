import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/controllers/daily_notifier.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/utils/game_formatters.dart';
import 'package:sudoku/widgets/app_card.dart';

/// Carte « Défi du jour » sur la home.
///
/// - Non joué aujourd'hui → bouton de lancement ([onPlay]).
/// - Gagné → temps effectif + verrou (revenez demain).
/// - Tenté (quitté sans gagner) → verrouillé (revenez demain).
class DailyCard extends ConsumerWidget {
  const DailyCard({super.key, required this.onPlay, this.isLoading = false});

  final VoidCallback onPlay;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final daily = ref.watch(dailyChallengeProvider).valueOrNull;

    final playedToday = daily?.playedToday ?? false;
    final wonToday = daily?.wonToday ?? false;
    final effectiveTime = daily?.record?.effectiveTime;

    final String subtitle;
    if (!playedToday) {
      subtitle = l10n.dailyCardPlay;
    } else if (wonToday && effectiveTime != null) {
      subtitle = l10n.dailyCardWon(formatDuration(effectiveTime));
    } else {
      subtitle = l10n.dailyCardComeBack;
    }

    final tappable = !playedToday && !isLoading;

    return AppCard(
      color: colorScheme.secondaryContainer,
      onTap: tappable ? onPlay : null,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                playedToday
                    ? (wonToday ? Icons.emoji_events_rounded : Icons.lock_clock)
                    : Icons.today_rounded,
                color: colorScheme.onSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dailyTitle,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSecondaryContainer.withValues(
                        alpha: 0.85,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else if (tappable)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: colorScheme.onSecondaryContainer.withValues(alpha: 0.6),
                size: 14,
              ),
          ],
        ),
      ),
    );
  }
}
