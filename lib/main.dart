import 'package:flutter/material.dart';
import 'repositories/game_repository.dart';
import 'repositories/settings_repository.dart';
import 'repositories/stats_repository.dart';
import 'controllers/settings_controller.dart';
import 'controllers/stats_controller.dart';
import 'sudoku_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final gameRepo = SharedPrefsGameRepository();
  final statsRepo = SharedPrefsStatsRepository();
  final settingsRepo = SharedPrefsSettingsRepository();

  final saved = await gameRepo.loadSaved();
  final statsController = StatsController(repository: statsRepo);
  final settingsController = SettingsController(repository: settingsRepo);
  await Future.wait([statsController.load(), settingsController.load()]);

  runApp(SudokuApp(
    repository: gameRepo,
    statsController: statsController,
    settingsController: settingsController,
    initialSaved: saved,
  ));
}
