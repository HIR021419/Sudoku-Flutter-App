import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/controllers/settings_notifier.dart';
import 'package:sudoku/entities/settings.dart';
import 'package:sudoku/entities/type/theme_preference_enum.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/widgets/app_card.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final settings =
        ref.watch(settingsNotifierProvider).valueOrNull ?? const Settings();
    final notifier = ref.read(settingsNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // --- Son & Haptique ---
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    onChanged: notifier.setSoundEnabled,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: Text(l10n.settingsHaptic),
                    secondary: Icon(
                      Icons.vibration_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    value: settings.hapticEnabled,
                    onChanged: notifier.setHapticEnabled,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: Text(l10n.settingsShowHintButton),
                    subtitle: Text(l10n.settingsShowHintButtonDescription),
                    secondary: Icon(
                      Icons.lightbulb_outline_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    value: settings.hintButtonVisible,
                    onChanged: notifier.setHintButtonVisible,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // --- Thème ---
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    child: SegmentedButton<ThemePreferenceEnum>(
                      segments: [
                        ButtonSegment(
                          value: ThemePreferenceEnum.system,
                          label: Text(l10n.themeSystem),
                          icon: const Icon(
                            Icons.brightness_auto_rounded,
                            size: 18,
                          ),
                        ),
                        ButtonSegment(
                          value: ThemePreferenceEnum.light,
                          label: Text(l10n.themeLight),
                          icon: const Icon(Icons.light_mode_rounded, size: 18),
                        ),
                        ButtonSegment(
                          value: ThemePreferenceEnum.dark,
                          label: Text(l10n.themeDark),
                          icon: const Icon(Icons.dark_mode_rounded, size: 18),
                        ),
                      ],
                      selected: {settings.theme},
                      onSelectionChanged: (s) => notifier.setTheme(s.first),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // --- Mode de validation ---
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.rule_folder_outlined,
                          color: colorScheme.onSurfaceVariant,
                          size: 22,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            l10n.settingsValidationMode,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RadioGroup<ValidationModeEnum>(
                    groupValue: settings.validationMode,
                    onChanged: (value) {
                      if (value != null) notifier.setValidationMode(value);
                    },
                    child: Column(
                      children: [
                        RadioListTile<ValidationModeEnum>(
                          title: Text(l10n.validationModeAutoCheck),
                          subtitle: Text(
                            l10n.validationModeAutoCheckDescription,
                          ),
                          value: ValidationModeEnum.autoCheck,
                        ),
                        const Divider(height: 1),
                        RadioListTile<ValidationModeEnum>(
                          title: Text(l10n.validationModeValidate),
                          subtitle: Text(
                            l10n.validationModeValidateDescription,
                          ),
                          value: ValidationModeEnum.validate,
                        ),
                        const Divider(height: 1),
                        RadioListTile<ValidationModeEnum>(
                          title: Text(l10n.validationModeNoCheck),
                          subtitle: Text(l10n.validationModeNoCheckDescription),
                          value: ValidationModeEnum.noCheck,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
