import 'dart:math';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/utils/board_geometry.dart';

/// Données d'un puzzle généré.
/// Fonction top-level pour pouvoir être passée à `compute()` et exécutée dans un isolate.
({List<int> solution, List<int> givens}) generatePuzzleData(
    DifficultyEnum difficulty) {
  final solution = SudokuUtils.generateGrid();
  final givens = SudokuUtils.generateGivens(solution, difficulty);
  return (solution: solution, givens: givens);
}

class SudokuUtils {
  static final _random = Random();

  /// Génère une grille 9×9 complète et valide (81 entrées ∈ 1..9).
  static List<int> generateGrid() {
    final grid = List<int>.filled(81, 0);
    _fillGrid(grid);
    return grid;
  }

  static bool _fillGrid(List<int> grid) {
    for (int i = 0; i < 81; i++) {
      if (grid[i] == 0) {
        final numbers = List<int>.generate(9, (i) => i + 1)..shuffle(_random);
        for (final number in numbers) {
          if (_isValid(grid, i, number)) {
            grid[i] = number;
            if (_fillGrid(grid)) return true;
            grid[i] = 0;
          }
        }
        return false;
      }
    }
    return true;
  }

  static bool _isValid(List<int> grid, int index, int value) {
    for (final peer in peerIndexesOf(index)) {
      if (grid[peer] == value) return false;
    }
    return true;
  }

  /// Génère la liste des indices de cases données (givens) **garantissant que
  /// le puzzle a exactement une solution**.
  ///
  /// Algorithme : part de la solution complète, retire les cases une par une
  /// dans un ordre aléatoire ; ne valide un retrait que si la grille reste
  /// résoluble de façon unique. Pour Expert, le nombre de givens peut être
  /// légèrement supérieur à `difficulty.clues` si l'unicité l'exige.
  static List<int> generateGivens(
      List<int> solution, DifficultyEnum difficulty) {
    final puzzle = List<int>.from(solution);
    final positions = List<int>.generate(81, (i) => i)..shuffle(_random);
    final target = 81 - difficulty.clues; // nb de cases à retirer
    int removed = 0;

    for (final pos in positions) {
      if (removed >= target) break;
      final backup = puzzle[pos];
      puzzle[pos] = 0;
      final workGrid = List<int>.from(puzzle);
      if (_countSolutions(workGrid, cap: 2) == 1) {
        removed++;
      } else {
        puzzle[pos] = backup; // retrait annulé → puzzle non unique
      }
    }

    return [for (int i = 0; i < 81; i++) if (puzzle[i] != 0) i];
  }

  /// Compte le nombre de solutions distinctes de `grid`, en s'arrêtant dès
  /// que `cap` est atteint (par défaut 2 — on n'a besoin que de distinguer
  /// "unique" de "multiple"). Mute `grid` puis le restaure.
  static int _countSolutions(List<int> grid, {int cap = 2}) {
    int count = 0;

    bool dfs() {
      for (int i = 0; i < 81; i++) {
        if (grid[i] == 0) {
          for (int v = 1; v <= 9; v++) {
            if (_isValid(grid, i, v)) {
              grid[i] = v;
              if (dfs()) {
                grid[i] = 0;
                return true; // cap atteint, propage l'arrêt
              }
              grid[i] = 0;
            }
          }
          return false;
        }
      }
      count++;
      return count >= cap;
    }

    dfs();
    return count;
  }
}
