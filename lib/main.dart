import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/repositories/game_repository.dart';
import 'package:sudoku/sudoku_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Précharge le saved avant runApp pour éviter un flicker initial sur le
  // bouton "Reprendre". Les notifiers Settings/Stats se chargent en lazy.
  final saved = await SharedPrefsGameRepository().loadSaved();
  runApp(ProviderScope(child: SudokuApp(initialSaved: saved)));
}
