import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstraction pour la persistance d'une partie en cours.
/// Permet de remplacer SharedPreferences par autre chose (Hive, fichier, mock test) sans toucher au model.
abstract class GameRepository {
  Future<Map<String, dynamic>?> loadSaved();
  Future<void> save(Map<String, dynamic> data);
  Future<void> clear();
}

class SharedPrefsGameRepository implements GameRepository {
  static const _key = 'saved_game';

  @override
  Future<Map<String, dynamic>?> loadSaved() async {
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

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
