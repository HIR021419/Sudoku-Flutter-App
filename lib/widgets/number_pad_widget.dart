import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/models/game_controller.dart';

class NumberPadWidget extends StatelessWidget {
  const NumberPadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // On observe seulement (fillMode, notesMode, activeNumber) — pas l'état domaine.
    final state = context.select<GameController, ({bool fillMode, bool notesMode, int? activeNumber})>(
      (c) => (
        fillMode: c.fillMode,
        notesMode: c.notesMode,
        activeNumber: c.activeNumber,
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 6.0;
        final buttonWidth = (constraints.maxWidth - spacing * 8) / 9;
        final buttonHeight = buttonWidth.clamp(40.0, 64.0);

        return SizedBox(
          height: buttonHeight,
          child: Row(
            children: List.generate(9, (i) {
              final number = i + 1;
              final isActive = state.fillMode && state.activeNumber == number;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i == 8 ? 0 : spacing),
                  child: _NumberButton(
                    number: number,
                    isActive: isActive,
                    isNotes: state.notesMode,
                    colorScheme: colorScheme,
                    onTap: () =>
                        context.read<GameController>().onNumberPadTap(number),
                  ),
                ),
              );
            }),
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
      border = colorScheme.tertiary.withValues(alpha: 0.4);
    } else {
      bg = colorScheme.surfaceContainerHigh;
      fg = colorScheme.onSurface;
      border = colorScheme.outlineVariant;
    }

    return Semantics(
      label: isNotes
          ? 'Toggle note $number'
          : (isActive ? 'Désactiver $number' : 'Saisir $number'),
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
