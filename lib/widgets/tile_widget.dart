import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/models/game_controller.dart';

/// View-model d'une tuile : record Dart 3 comparé par valeur natif.
/// Les notes sont encodées en bitmask 9 bits (bit i = note i+1) pour que
/// l'égalité du record reste valide même si la Set sous-jacente est mutée en place.
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
    final semanticLabel = _buildSemanticLabel(row, col, vm);

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

  /// Construit le contenu de la tuile avec une clé stable par état pour
  /// que AnimatedSwitcher anime correctement les transitions :
  /// - clé "val-X" : valeur posée X (chaque valeur = key différente)
  /// - clé "notes" : présence de notes (changement de notesMask = même key, pas d'animation)
  /// - clé "empty" : case vide sans note
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

  String _buildSemanticLabel(int row, int col, _TileVm vm) {
    final parts = <String>['Cellule ligne $row colonne $col'];
    if (vm.value == 0) {
      if (vm.notesMask == 0) {
        parts.add('vide');
      } else {
        final notes = <int>[];
        for (int i = 0; i < 9; i++) {
          if (vm.notesMask & (1 << i) != 0) notes.add(i + 1);
        }
        parts.add('notes $notes');
      }
    } else {
      parts.add('valeur ${vm.value}');
    }
    if (vm.isGiven) parts.add('initiale');
    if (vm.hasError) parts.add('erreur');
    if (vm.isSelected) parts.add('sélectionnée');
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
    // L'erreur écrase la sélection visuellement (rouge bien marqué pour qu'on ne le confonde pas avec un given).
    if (hasError) return cs.error.withValues(alpha: 0.38);
    if (isSelected) return cs.primary.withValues(alpha: 0.28);
    if (isSameValue) return cs.primary.withValues(alpha: 0.16);
    if (isRelated) return cs.primary.withValues(alpha: 0.06);
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
