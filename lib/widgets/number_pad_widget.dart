import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/controllers/game_controller.dart';

class NumberPadWidget extends StatelessWidget {
  const NumberPadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = context
        .select<
          GameController,
          ({
            bool fillMode,
            bool notesMode,
            int? activeNumber,
            int completedMask,
          })
        >(
          (c) => (
            fillMode: c.fillMode,
            notesMode: c.notesMode,
            activeNumber: c.activeNumber,
            completedMask: c.completedNumbersMask,
          ),
        );
    final visibleNumbers = [
      for (int number = 1; number <= 9; number++)
        if (state.completedMask & (1 << (number - 1)) == 0) number,
    ];

    if (visibleNumbers.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 6.0;
        final buttonWidth =
            (constraints.maxWidth - spacing * (visibleNumbers.length - 1)) /
            visibleNumbers.length;
        final buttonHeight = buttonWidth.clamp(40.0, 64.0);

        return SizedBox(
          height: buttonHeight,
          child: Row(
            children: [
              for (int i = 0; i < visibleNumbers.length; i++) ...[
                if (i > 0) const SizedBox(width: spacing),
                Expanded(
                  child: _NumberButton(
                    number: visibleNumbers[i],
                    isActive:
                        state.fillMode &&
                        state.activeNumber == visibleNumbers[i],
                    isNotes: state.notesMode,
                    colorScheme: colorScheme,
                    onTap: () => context.read<GameController>().onNumberPadTap(
                      visibleNumbers[i],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _NumberButton extends StatelessWidget {
  const _NumberButton({
    required this.number,
    required this.isActive,
    required this.isNotes,
    required this.colorScheme,
    required this.onTap,
  });

  final int number;
  final bool isActive;
  final bool isNotes;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final Color bg;
    final Color fg;
    final Color border;

    if (isActive) {
      bg = colorScheme.primary;
      fg = colorScheme.onPrimary;
      border = colorScheme.primary;
    } else if (isNotes) {
      bg = colorScheme.tertiaryContainer;
      fg = colorScheme.onTertiaryContainer;
      border = colorScheme.tertiary.withValues(alpha: 0.5);
    } else {
      bg = colorScheme.surfaceContainerHigh;
      fg = colorScheme.onSurface;
      border = colorScheme.outlineVariant;
    }

    return Semantics(
      label: isNotes
          ? l10n.numberPadToggleNote(number)
          : (isActive
                ? l10n.numberPadDeactivate(number)
                : l10n.numberPadEnter(number)),
      button: true,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: border, width: 1),
            ),
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  number.toString(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: fg,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
