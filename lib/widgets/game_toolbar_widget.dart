import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/controllers/game_notifier.dart';
import 'package:sudoku/controllers/settings_notifier.dart';
import 'package:sudoku/entities/settings.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';
import 'package:sudoku/l10n/app_localizations.dart';

class GameToolbarWidget extends ConsumerWidget {
  const GameToolbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final ui = ref.watch(gameNotifierProvider.select((s) => s?.ui));
    final validationMode = ref.watch(
      settingsNotifierProvider.select(
        (s) =>
            s.valueOrNull?.validationMode ?? const Settings().validationMode,
      ),
    );
    final hintButtonVisible = ref.watch(
      settingsNotifierProvider.select(
        (s) =>
            s.valueOrNull?.hintButtonVisible ??
            const Settings().hintButtonVisible,
      ),
    );
    final notifier = ref.read(gameNotifierProvider.notifier);

    final notesMode = ui?.notesMode ?? false;
    final fillMode = ui?.fillMode ?? false;

    final buttons = <Widget>[
      _ToolbarButton(
        icon: Icons.undo_rounded,
        label: l10n.toolbarUndo,
        onTap: notifier.undo,
      ),
      _ToolbarButton(
        icon: Icons.backspace_outlined,
        label: l10n.toolbarErase,
        onTap: notifier.eraseCell,
      ),
      _ToolbarButton(
        icon: Icons.edit_note_rounded,
        label: l10n.toolbarNotes,
        onTap: notifier.toggleNotesMode,
        isActive: notesMode,
      ),
      _ToolbarButton(
        icon: Icons.bolt_rounded,
        label: l10n.toolbarFast,
        onTap: notifier.toggleFillMode,
        isActive: fillMode,
      ),
      if (hintButtonVisible)
        _ToolbarButton(
          icon: Icons.lightbulb_outline_rounded,
          label: l10n.toolbarHint,
          onTap: notifier.hint,
        ),
      if (validationMode == ValidationModeEnum.validate)
        _ToolbarButton(
          icon: Icons.fact_check_outlined,
          label: l10n.toolbarValidate,
          onTap: notifier.validateBoard,
        ),
    ];

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
