import 'package:flutter/foundation.dart';
import 'package:sudoku/repositories/stats_repository.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/entities/stats.dart';

/// ChangeNotifier qui expose [Stats] et gère la persistance.
/// Une seule instance partagée pour toute l'app, fournie via Provider à la racine.
class StatsController extends ChangeNotifier {
  StatsController({required StatsRepository repository}) : _repo = repository;

  final StatsRepository _repo;
  Stats _stats = Stats.empty();
  bool _loaded = false;

  Stats get stats => _stats;
  bool get isLoaded => _loaded;

  /// À appeler une fois au boot pour hydrater depuis SharedPreferences.
  Future<void> load() async {
    final json = await _repo.load();
    _stats = Stats.fromJson(json);
    _loaded = true;
    notifyListeners();
  }

  /// Enregistre une victoire — met à jour gamesSolved et bestTime si meilleur.
  Future<void> recordWin(DifficultyEnum difficulty, Duration time) async {
    _stats = _stats.withWin(difficulty, time);
    notifyListeners();
    try {
      await _repo.save(_stats.toJson());
    } catch (e, st) {
      debugPrint('StatsController.recordWin save failed: $e\n$st');
    }
  }
}
