import 'package:flutter/material.dart';
import 'data/game_repository.dart';
import 'sudoku_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = SharedPrefsGameRepository();
  final saved = await repository.loadSaved();
  runApp(SudokuApp(repository: repository, initialSaved: saved));
}
