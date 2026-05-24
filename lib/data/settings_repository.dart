import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepository {
  Future<Map<String, dynamic>?> load();
  Future<void> save(Map<String, dynamic> data);
}

class SharedPrefsSettingsRepository implements SettingsRepository {
  static const _key = 'settings';

  @override
  Future<Map<String, dynamic>?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_key);
    if (str == null) return null;
    try {
      final decoded = jsonDecode(str);
      if (decoded is! Map<String, dynamic>) return null;
      return decoded;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(data));
  }
}
