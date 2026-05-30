import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/entities/_schema_versions.dart';
import 'package:sudoku/entities/migrations/settings_migration.dart';
import 'package:sudoku/entities/settings.dart';
import 'package:sudoku/entities/type/theme_preference_enum.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';
import 'package:sudoku/providers/repositories.dart';

part 'settings_notifier.g.dart';

/// AsyncNotifier qui expose [Settings] et gère sa persistance.
///
/// Lecture initiale via `build()` (asynchrone, lazy au premier `ref.watch`).
/// Toute mutation passe par `update(...)` qui fait `state = AsyncData(newSettings)`
/// puis persiste en arrière-plan.
@Riverpod(keepAlive: true)
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<Settings> build() async {
    final repo = ref.read(settingsRepositoryProvider);
    final json = await repo.load();
    return _hydrate(json);
  }

  Settings _hydrate(Map<String, dynamic>? json) {
    if (json == null) return const Settings();
    final migrated = SettingsMigration.migrate(json);
    if (migrated == null) return const Settings();
    try {
      return Settings.fromJson(migrated);
    } catch (_) {
      return const Settings();
    }
  }

  Future<void> setSoundEnabled(bool value) =>
      _update((s) => s.copyWith(soundEnabled: value));

  Future<void> setHapticEnabled(bool value) =>
      _update((s) => s.copyWith(hapticEnabled: value));

  Future<void> setTheme(ThemePreferenceEnum value) =>
      _update((s) => s.copyWith(theme: value));

  Future<void> setValidationMode(ValidationModeEnum value) =>
      _update((s) => s.copyWith(validationMode: value));

  Future<void> setHintButtonVisible(bool value) =>
      _update((s) => s.copyWith(hintButtonVisible: value));

  Future<void> _update(Settings Function(Settings) mutate) async {
    final current = state.valueOrNull;
    if (current == null) return;
    final next = mutate(current);
    if (next == current) return;
    state = AsyncData(next);
    try {
      await ref.read(settingsRepositoryProvider).save({
        ...next.toJson(),
        'schemaVersion': kSettingsSchemaVersion,
      });
    } catch (e, st) {
      debugPrint('SettingsNotifier._update save failed: $e\n$st');
    }
  }
}
