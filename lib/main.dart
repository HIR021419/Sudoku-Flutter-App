import 'package:flutter/material.dart';
import 'data/game_repository.dart';
import 'data/settings_repository.dart';
import 'data/stats_repository.dart';
import 'models/settings_controller.dart';
import 'models/stats_controller.dart';
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
