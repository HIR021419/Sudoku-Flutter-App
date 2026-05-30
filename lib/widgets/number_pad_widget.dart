import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/controllers/game_notifier.dart';
import 'package:sudoku/l10n/app_localizations.dart';

/// Tous les nombres complétés (1..9 = bits 0..8 → 0x1FF).
const int _allNumbersMask = 0x1FF;

class NumberPadWidget extends ConsumerWidget {
  const NumberPadWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final ui = ref.watch(gameNotifierProvider.select((s) => s?.ui));
    final completedMask = ref.watch(
      gameNotifierProvider.select((s) => s?.session.completedNumbersMask ?? 0),
    );

    if (ui == null) return const SizedBox.shrink();

    // Si tous les nombres sont placés, on cache totalement le numpad
    // (la partie est probablement gagnée — WinDialog prend le relais).
    if (completedMask == _allNumbersMask) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 6.0;
        const slotCount = 9;
        final slotWidth =
            (constraints.maxWidth - spacing * (slotCount - 1)) / slotCount;
        final buttonHeight = slotWidth.clamp(40.0, 64.0);

        return SizedBox(
          height: buttonHeight,
          child: Row(
            children: [
              for (int number = 1; number <= 9; number++) ...[
                if (number > 1) const SizedBox(width: spacing),
                Expanded(
                  child: (completedMask & (1 << (number - 1))) != 0
                      // Slot préservé mais vide pour ce nombre déjà complété.
                      // L'utilisateur conserve un repère visuel constant.
                      ? const SizedBox.shrink()
                      : _NumberButton(
                          number: number,
                          isActive: ui.fillMode && ui.activeNumber == number,
                          isNotes: ui.notesMode,
                          colorScheme: colorScheme,
                          onTap: () => ref
                              .read(gameNotifierProvider.notifier)
                              .onNumberPadTap(number),
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
