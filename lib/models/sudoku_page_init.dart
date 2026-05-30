import 'package:sudoku/entities/type/difficulty_enum.dart';

/// Argument d'initialisation de [SudokuPage] : soit une nouvelle partie déjà
/// générée (newGame), soit un blob JSON à restaurer.
///
/// La page lit l'arg en `initState` et appelle la méthode correspondante du
/// `GameNotifier`. C'est l'unique point d'entrée pour démarrer / reprendre
/// une partie.
sealed class SudokuPageInit {
  const SudokuPageInit();
}

class NewGameInit extends SudokuPageInit {
  const NewGameInit({
    required this.difficulty,
    required this.solution,
    required this.givens,
  });

  final DifficultyEnum difficulty;
  final List<int> solution;
  final List<int> givens;
}

class RestoreGameInit extends SudokuPageInit {
  const RestoreGameInit({required this.savedJson});

  final Map<String, dynamic> savedJson;
}
