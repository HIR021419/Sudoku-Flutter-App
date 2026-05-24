// Smoke test minimal — vérifie juste que l'app peut être instanciée
// avec des repositories en mémoire. Les vrais tests viendront dans une itération dédiée.

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/data/game_repository.dart';
import 'package:sudoku/data/settings_repository.dart';
import 'package:sudoku/data/stats_repository.dart';
import 'package:sudoku/models/settings_controller.dart';
import 'package:sudoku/models/stats_controller.dart';
import 'package:sudoku/sudoku_app.dart';

class _InMemoryGameRepository implements GameRepository {
  Map<String, dynamic>? _data;

  @override
  Future<Map<String, dynamic>?> loadSaved() async => _data;

  @override
  Future<void> save(Map<String, dynamic> data) async => _data = data;

  @override
  Future<void> clear() async => _data = null;
}

class _InMemoryMapRepository implements StatsRepository, SettingsRepository {
  Map<String, dynamic>? _data;

  @override
  Future<Map<String, dynamic>?> load() async => _data;

  @override
  Future<void> save(Map<String, dynamic> data) async => _data = data;
}

void main() {
  testWidgets('App boots without a saved game', (tester) async {
    final stats = StatsController(repository: _InMemoryMapRepository());
    final settings = SettingsController(repository: _InMemoryMapRepository());
    await stats.load();
    await settings.load();
    await tester.pumpWidget(SudokuApp(
      repository: _InMemoryGameRepository(),
      statsController: stats,
      settingsController: settings,
    ));
    await tester.pumpAndSettle();
    expect(find.text('Sudoku'), findsOneWidget);
  });
}
