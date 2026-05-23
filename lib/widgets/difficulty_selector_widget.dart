import 'package:flutter/material.dart';
import 'package:sudoku/entities/difficulty_enum.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/l10n/difficulty_l10n.dart';

class DifficultySelectorWidget extends StatefulWidget {
  const DifficultySelectorWidget({
    super.key,
    required this.onPlay,
    this.isLoading = false,
  });

  final ValueChanged<DifficultyEnum> onPlay;
  final bool isLoading;

  @override
  State<DifficultySelectorWidget> createState() =>
      _DifficultySelectorWidgetState();
}

class _DifficultySelectorWidgetState extends State<DifficultySelectorWidget> {
  int _index = 0;

  void _play() {
    widget.onPlay(DifficultyEnum.values[_index]);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.homeChooseDifficulty,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(DifficultyEnum.values.length, (i) {
          final difficulty = DifficultyEnum.values[i];
          final isSelected = i == _index;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _DifficultyCard(
              difficulty: difficulty,
              isSelected: isSelected,
              onTap: widget.isLoading
                  ? null
                  : () => setState(() => _index = i),
            ),
          );
        }),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: widget.isLoading ? null : _play,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: widget.isLoading
              ? SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                )
              : Text(l10n.homePlayButton),
        ),
      ],
    );
  }
}

class _DifficultyCard extends StatelessWidget {
  const _DifficultyCard({
    required this.difficulty,
    required this.isSelected,
    required this.onTap,
  });

  final DifficultyEnum difficulty;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final borderColor =
        isSelected ? colorScheme.primary : colorScheme.outlineVariant;
    final bgColor = isSelected
        ? colorScheme.primaryContainer.withValues(alpha: 0.4)
        : colorScheme.surfaceContainerLow;

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: borderColor,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _iconFor(difficulty),
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      difficulty.localizedLabel(context),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.difficultyCluesCount(difficulty.clues),
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: colorScheme.primary, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconFor(DifficultyEnum d) => switch (d) {
        DifficultyEnum.easy => Icons.sentiment_very_satisfied,
        DifficultyEnum.medium => Icons.sentiment_satisfied,
        DifficultyEnum.hard => Icons.sentiment_neutral,
        DifficultyEnum.expert => Icons.local_fire_department,
      };
}
