import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/controllers/game_notifier.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/utils/board_geometry.dart';

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

class TileWidget extends ConsumerWidget {
  const TileWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    final vm = ref.watch(
      gameNotifierProvider.select<_TileVm>((state) {
        if (state == null) {
          return (
            value: 0,
            isGiven: false,
            isSelected: false,
            isRelated: false,
            isSameValue: false,
            hasError: false,
            notesMask: 0,
          );
        }
        final session = state.session;
        final ui = state.ui;
        final selected = ui.selectedIndex;
        final isSelected = selected == index;

        // isRelated : même ligne/col/box que la case sélectionnée.
        bool isRelated = false;
        if (selected != null && !isSelected) {
          isRelated = rowOf(index) == rowOf(selected) ||
              colOf(index) == colOf(selected) ||
              boxOf(index) == boxOf(selected);
        }

        // isSameValue : même valeur que la case sélectionnée (ou que
        // l'active number en fillMode).
        final ref0 = ui.fillMode
            ? ui.activeNumber
            : (selected != null ? session.valueAt(selected) : null);
        final isSameValue = ref0 != null &&
            ref0 != 0 &&
            session.valueAt(index) == ref0 &&
            index != selected;

        return (
          value: session.valueAt(index),
          isGiven: session.isGiven(index),
          isSelected: isSelected,
          isRelated: isRelated,
          isSameValue: isSameValue,
          hasError: session.hasVisibleError(index),
          notesMask: _notesToMask(session.notesAt(index)),
        );
      }),
    );

    final row = rowOf(index) + 1;
    final col = colOf(index) + 1;
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
        onTap: () => ref.read(gameNotifierProvider.notifier).onTileTap(index),
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
