import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/models/game_controller.dart';

class GameToolbarWidget extends StatelessWidget {
  const GameToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // On observe les flags qui changent les états des boutons.
    final flags = context.select<GameController, ({bool notesMode, bool fillMode})>(
      (c) => (notesMode: c.notesMode, fillMode: c.fillMode),
    );
    final controller = context.read<GameController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
      ],
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

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Semantics(
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
        ),
      ),
    );
  }
}
