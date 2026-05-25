import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/controllers/game_controller.dart';

typedef _TileVm = ({
  int value,
  bool isGiven,
  bool isSelected,
  bool isRelated,
  bool isSameValue,
  bool hasError,
  int notesMask,
});

int _notesToMask(Set<int> notes) {
  int mask = 0;
  for (final n in notes) {
    if (n >= 1 && n <= 9) mask |= 1 << (n - 1);
  }
  return mask;
}

class TileWidget extends StatelessWidget {
  const TileWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final vm = context.select<GameController, _TileVm>(
      (c) => (
        value: c.valueAt(index),
        isGiven: c.isGiven(index),
        isSelected: c.isSelected(index),
        isRelated: c.isRelated(index),
        isSameValue: c.isSameValue(index),
        hasError: c.hasError(index),
        notesMask: _notesToMask(c.notesAt(index)),
      ),
    );

    final row = index ~/ 9 + 1;
    final col = index % 9 + 1;
    final semanticLabel = _buildSemanticLabel(l10n, row, col, vm);

    return Material(
      color: _backgroundColor(
        colorScheme,
        isSelected: vm.isSelected,
        hasError: vm.hasError,
        isSameValue: vm.isSameValue,
        isRelated: vm.isRelated,
      ),
      child: InkWell(
        onTap: () => context.read<GameController>().onTileTap(index),
        child: Semantics(
          label: semanticLabel,
          button: true,
          selected: vm.isSelected,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.5, end: 1).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: _buildTileContent(vm, colorScheme),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTileContent(_TileVm vm, ColorScheme colorScheme) {
    if (vm.value != 0) {
      return FittedBox(
        key: ValueKey('val-${vm.value}'),
        fit: BoxFit.scaleDown,
        child: Text(
          vm.value.toString(),
          style: TextStyle(
            fontSize: 26,
            fontWeight: vm.isGiven ? FontWeight.w700 : FontWeight.w600,
            color: _textColor(
              colorScheme,
              isGiven: vm.isGiven,
              hasError: vm.hasError,
            ),
          ),
        ),
      );
    }
    if (vm.notesMask != 0) {
      return KeyedSubtree(
        key: const ValueKey('notes'),
        child: _buildNotes(vm.notesMask, colorScheme),
      );
    }
    return const SizedBox.shrink(key: ValueKey('empty'));
  }

  String _buildSemanticLabel(
    AppLocalizations l10n,
    int row,
    int col,
    _TileVm vm,
  ) {
    final parts = <String>[l10n.tileSemanticPosition(row, col)];
    if (vm.value == 0) {
      if (vm.notesMask == 0) {
        parts.add(l10n.tileSemanticEmpty);
      } else {
        final notes = <int>[];
        for (int i = 0; i < 9; i++) {
          if (vm.notesMask & (1 << i) != 0) notes.add(i + 1);
        }
        parts.add(l10n.tileSemanticNotes(notes.join(', ')));
      }
    } else {
      parts.add(l10n.tileSemanticValue(vm.value));
    }
    if (vm.isGiven) parts.add(l10n.tileSemanticGiven);
    if (vm.hasError) parts.add(l10n.tileSemanticError);
    if (vm.isSelected) parts.add(l10n.tileSemanticSelected);
    return parts.join(', ');
  }

  Widget _buildNotes(int notesMask, ColorScheme colorScheme) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      children: List.generate(9, (i) {
        final n = i + 1;
        final present = notesMask & (1 << i) != 0;
        return Center(
          child: present
              ? FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    n.toString(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : null,
        );
      }),
    );
  }

  Color _backgroundColor(
    ColorScheme cs, {
    required bool isSelected,
    required bool hasError,
    required bool isSameValue,
    required bool isRelated,
  }) {
    final isDark = cs.brightness == Brightness.dark;
    if (hasError) {
      return Color.alphaBlend(
        cs.error.withValues(alpha: isDark ? 0.40 : 0.22),
        cs.surface,
      );
    }
    if (isSelected) {
      return Color.alphaBlend(
        cs.primary.withValues(alpha: isDark ? 0.46 : 0.28),
        cs.surface,
      );
    }
    if (isSameValue) {
      return Color.alphaBlend(
        cs.secondary.withValues(alpha: isDark ? 0.30 : 0.18),
        cs.surface,
      );
    }
    if (isRelated) {
      return Color.alphaBlend(
        cs.primary.withValues(alpha: isDark ? 0.18 : 0.10),
        cs.surface,
      );
    }
    return cs.surface;
  }

  Color _textColor(
    ColorScheme cs, {
    required bool isGiven,
    required bool hasError,
  }) {
    if (hasError) return cs.error;
    if (isGiven) return cs.onSurface;
    return cs.primary;
  }
}
