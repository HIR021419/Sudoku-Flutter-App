import 'package:flutter/foundation.dart';
import 'package:sudoku/entities/type/theme_preference_enum.dart';
import 'package:sudoku/entities/type/validation_mode_enum.dart';
import 'package:sudoku/repositories/settings_repository.dart';
import 'package:sudoku/entities/settings.dart';

class SettingsController extends ChangeNotifier {
  SettingsController({required SettingsRepository repository})
    : _repo = repository;

  final SettingsRepository _repo;
  Settings _settings = const Settings();
  bool _loaded = false;

  Settings get settings => _settings;
  bool get isLoaded => _loaded;

  Future<void> load() async {
    final json = await _repo.load();
    _settings = Settings.fromJson(json);
    _loaded = true;
    notifyListeners();
  }

  Future<void> setSoundEnabled(bool value) async {
    if (_settings.soundEnabled == value) return;
    _settings = _settings.copyWith(soundEnabled: value);
    notifyListeners();
    await _persist();
  }

  Future<void> setHapticEnabled(bool value) async {
    if (_settings.hapticEnabled == value) return;
    _settings = _settings.copyWith(hapticEnabled: value);
    notifyListeners();
    await _persist();
  }

  Future<void> setTheme(ThemePreferenceEnum value) async {
    if (_settings.theme == value) return;
    _settings = _settings.copyWith(theme: value);
    notifyListeners();
    await _persist();
  }

  Future<void> setValidationMode(ValidationModeEnum value) async {
    if (_settings.validationMode == value) return;
    _settings = _settings.copyWith(validationMode: value);
    notifyListeners();
    await _persist();
  }

  Future<void> _persist() async {
    try {
      await _repo.save(_settings.toJson());
    } catch (e, st) {
      debugPrint('SettingsController._persist failed: $e\n$st');
    }
  }
}
