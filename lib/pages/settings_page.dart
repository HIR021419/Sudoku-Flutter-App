import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/models/settings.dart';
import 'package:sudoku/models/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final settings = context.watch<SettingsController>().settings;
    final controller = context.read<SettingsController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            _SectionCard(
              children: [
                SwitchListTile(
                  title: Text(l10n.settingsSound),
                  secondary: Icon(
                    settings.soundEnabled
                        ? Icons.volume_up_rounded
                        : Icons.volume_off_rounded,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  value: settings.soundEnabled,
                  onChanged: controller.setSoundEnabled,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: Text(l10n.settingsHaptic),
                  secondary: Icon(
                    Icons.vibration_rounded,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  value: settings.hapticEnabled,
                  onChanged: controller.setHapticEnabled,
                ),
              ],
            ),
            const SizedBox(height: 12),
            _SectionCard(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.palette_outlined,
                        color: colorScheme.onSurfaceVariant,
                        size: 22,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        l10n.settingsTheme,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: SegmentedButton<ThemePreference>(
                    segments: [
                      ButtonSegment(
                        value: ThemePreference.system,
                        label: Text(l10n.themeSystem),
                        icon: const Icon(Icons.brightness_auto_rounded, size: 18),
                      ),
                      ButtonSegment(
                        value: ThemePreference.light,
                        label: Text(l10n.themeLight),
                        icon: const Icon(Icons.light_mode_rounded, size: 18),
                      ),
                      ButtonSegment(
                        value: ThemePreference.dark,
                        label: Text(l10n.themeDark),
                        icon: const Icon(Icons.dark_mode_rounded, size: 18),
                      ),
                    ],
                    selected: {settings.theme},
                    onSelectionChanged: (s) => controller.setTheme(s.first),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
