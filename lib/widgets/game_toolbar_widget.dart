import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/controllers/game_controller.dart';

class GameToolbarWidget extends StatelessWidget {
  const GameToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final flags = context
        .select<
          GameController,
          ({bool notesMode, bool fillMode, ValidationModeEnum validationMode})
        >(
          (c) => (
            notesMode: c.notesMode,
            fillMode: c.fillMode,
            validationMode: c.validationMode,
          ),
        );
    final controller = context.read<GameController>();
    final buttons = <Widget>[
      _ToolbarButton(
        icon: Icons.undo_rounded,
        label: l10n.toolbarUndo,
        onTap: controller.undo,
      ),
      _ToolbarButton(
        icon: Icons.backspace_outlined,
        label: l10n.toolbarErase,
        onTap: controller.eraseCell,
      ),
      _ToolbarButton(
        icon: Icons.edit_note_rounded,
        label: l10n.toolbarNotes,
        onTap: controller.toggleNotesMode,
        isActive: flags.notesMode,
      ),
      _ToolbarButton(
        icon: Icons.bolt_rounded,
        label: l10n.toolbarFast,
        onTap: controller.toggleFillMode,
        isActive: flags.fillMode,
      ),
      _ToolbarButton(
        icon: Icons.lightbulb_outline_rounded,
        label: l10n.toolbarHint,
        onTap: controller.hint,
      ),
    ];

    if (flags.validationMode == ValidationModeEnum.validate) {
      buttons.add(
        _ToolbarButton(
          icon: Icons.fact_check_outlined,
          label: l10n.toolbarValidate,
          onTap: controller.validateBoard,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 8.0;
        final buttonsPerRow = constraints.maxWidth >= 420
            ? buttons.length
            : (buttons.length > 5 ? 3 : buttons.length);
        final buttonWidth =
            (constraints.maxWidth - spacing * (buttonsPerRow - 1)) /
            buttonsPerRow;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final button in buttons)
              SizedBox(width: buttonWidth, child: button),
          ],
        );
      },
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bg = isActive
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerHighest;
    final fg = isActive
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurfaceVariant;

    return Semantics(
      label: isActive ? '$label (actif)' : label,
      button: true,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: fg, size: 24),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: fg,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
