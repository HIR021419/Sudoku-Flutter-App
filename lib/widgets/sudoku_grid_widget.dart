import 'package:flutter/material.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/widgets/tile_widget.dart';

class SudokuGridWidget extends StatelessWidget {
  const SudokuGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final outline = colorScheme.outline;
    final thinLine = colorScheme.outlineVariant.withValues(alpha: 0.6);

    return Semantics(
      container: true,
      label: l10n.gridSemanticLabel,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border.all(color: outline, width: 2),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: GridView.builder(
          itemCount: 81,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 9,
          ),
          itemBuilder: (context, index) {
            final row = index ~/ 9;
            final col = index % 9;
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: row == 0 ? 0 : (row % 3 == 0 ? 1.5 : 0.5),
                    color: row % 3 == 0 ? outline : thinLine,
                  ),
                  left: BorderSide(
                    width: col == 0 ? 0 : (col % 3 == 0 ? 1.5 : 0.5),
                    color: col % 3 == 0 ? outline : thinLine,
                  ),
                ),
              ),
              child: TileWidget(index: index),
            );
          },
        ),
      ),
    );
  }
}
