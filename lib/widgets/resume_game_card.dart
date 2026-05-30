import 'package:flutter/material.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/l10n/difficulty_l10n.dart';
import 'package:sudoku/utils/game_formatters.dart';
import 'package:sudoku/widgets/app_card.dart';

class ResumeGameCard extends StatelessWidget {
  const ResumeGameCard({
    super.key,
    required this.saved,
    required this.onTap,
  });

  final Map<String, dynamic> saved;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    final difficulty = DifficultyEnum.tryParse(saved['difficulty'] as String?);
    final elapsedMs = (saved['elapsedMs'] as num?)?.toInt() ?? 0;
    final elapsed = Duration(milliseconds: elapsedMs);

    return AppCard(
      color: colorScheme.primaryContainer,
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: colorScheme.onPrimary,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.homeResumeTitle,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (difficulty != null) ...[
                          Text(
                            difficulty.localizedLabel(context),
                            style: TextStyle(
                              fontSize: 13,
                              color: colorScheme.onPrimaryContainer
                                  .withValues(alpha: 0.85),
                            ),
                          ),
                          Text(
                            ' · ',
                            style: TextStyle(
                              color: colorScheme.onPrimaryContainer
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                        Icon(
                          Icons.timer_outlined,
                          size: 13,
                          color: colorScheme.onPrimaryContainer
                              .withValues(alpha: 0.85),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          formatDuration(elapsed),
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onPrimaryContainer
                                .withValues(alpha: 0.85),
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: colorScheme.onPrimaryContainer.withValues(alpha: 0.6),
                size: 14,
              ),
            ],
          ),
        ),
    );
  }
}

