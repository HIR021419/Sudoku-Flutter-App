import 'dart:math';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/utils/board_geometry.dart';

/// Données d'un puzzle généré.
/// Fonction top-level pour pouvoir être passée à `compute()` et exécutée dans un isolate.
({List<int> solution, List<int> givens}) generatePuzzleData(
  DifficultyEnum difficulty,
) {
  final solution = SudokuUtils.generateGrid();
  final givens = SudokuUtils.generateGivens(solution, difficulty);
  return (solution: solution, givens: givens);
}

/// Variante **déterministe** : même `(difficulty, seed)` → même puzzle, sur
/// toutes les plateformes (Dart `Random(seed)` est stable). Utilisée par le
/// défi du jour pour produire la même grille pour tous les joueurs.
/// Argument unique (record) pour être compatible avec `compute()`.
({List<int> solution, List<int> givens}) generateSeededPuzzleData(
  (DifficultyEnum difficulty, int seed) arg,
) {
  final (difficulty, seed) = arg;
  final random = Random(seed);
  final solution = SudokuUtils.generateGrid(random);
  final givens = SudokuUtils.generateGivens(solution, difficulty, random);
  return (solution: solution, givens: givens);
}

class SudokuUtils {
  static final _random = Random();

  /// Génère une grille 9×9 complète et valide (81 entrées ∈ 1..9).
  /// [random] permet une génération déterministe (défi du jour) ; par défaut,
  /// source aléatoire partagée.
  static List<int> generateGrid([Random? random]) {
    final grid = List<int>.filled(81, 0);
    _fillGrid(grid, random ?? _random);
    return grid;
  }

  static bool _fillGrid(List<int> grid, Random random) {
    for (int i = 0; i < 81; i++) {
      if (grid[i] == 0) {
        final numbers = List<int>.generate(9, (i) => i + 1)..shuffle(random);
        for (final number in numbers) {
          if (_isValid(grid, i, number)) {
            grid[i] = number;
            if (_fillGrid(grid, random)) return true;
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
    List<int> solution,
    DifficultyEnum difficulty, [
    Random? random,
  ]) {
    final puzzle = List<int>.from(solution);
    final positions = List<int>.generate(81, (i) => i)
      ..shuffle(random ?? _random);
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

    return [
      for (int i = 0; i < 81; i++)
        if (puzzle[i] != 0) i,
    ];
  }

  /// Compte le nombre de solutions distinctes de `grid`, en s'arrêtant dès que
  /// `cap` est atteint (par défaut 2 — on distingue juste "unique" de
  /// "multiple"). N'altère pas `grid` (travaille sur une copie).
  ///
  /// Solveur rapide : masques de bits par ligne/colonne/bloc + sélection de la
  /// case la plus contrainte (MRV). Beaucoup plus rapide que le backtracking
  /// naïf, en particulier pour la génération **Expert** (grilles très creuses) —
  /// la génération appelle ce compteur jusqu'à ~60 fois.
  static int _countSolutions(List<int> grid, {int cap = 2}) {
    final work = List<int>.of(grid);
    final rows = List<int>.filled(9, 0);
    final cols = List<int>.filled(9, 0);
    final boxes = List<int>.filled(9, 0);

    for (int i = 0; i < 81; i++) {
      final v = work[i];
      if (v == 0) continue;
      final bit = 1 << (v - 1);
      rows[i ~/ 9] |= bit;
      cols[i % 9] |= bit;
      boxes[boxOf(i)] |= bit;
    }

    int count = 0;

    bool dfs() {
      // MRV : choisir la case vide ayant le moins de candidats.
      int best = -1;
      int bestCand = 0;
      int bestCount = 10;
      for (int i = 0; i < 81; i++) {
        if (work[i] != 0) continue;
        final cand =
            (~(rows[i ~/ 9] | cols[i % 9] | boxes[boxOf(i)])) & 0x1FF;
        if (cand == 0) return false; // impasse : élagage immédiat
        final n = _popcount9(cand);
        if (n < bestCount) {
          bestCount = n;
          best = i;
          bestCand = cand;
          if (n == 1) break;
        }
      }

      if (best == -1) {
        count++;
        return count >= cap; // grille pleine → une solution de plus
      }

      final r = best ~/ 9;
      final c = best % 9;
      final b = boxOf(best);
      int cand = bestCand;
      while (cand != 0) {
        final bit = cand & (-cand); // bit le plus bas
        cand ^= bit;
        work[best] = _lowestBitValue(bit);
        rows[r] |= bit;
        cols[c] |= bit;
        boxes[b] |= bit;
        final stop = dfs();
        work[best] = 0;
        rows[r] ^= bit;
        cols[c] ^= bit;
        boxes[b] ^= bit;
        if (stop) return true;
      }
      return false;
    }

    dfs();
    return count;
  }

  /// Nombre de bits à 1 dans un masque 9 bits.
  static int _popcount9(int mask) {
    int n = 0;
    while (mask != 0) {
      mask &= mask - 1;
      n++;
    }
    return n;
  }

  /// Valeur 1..9 correspondant à un masque à un seul bit (bit N-1 → N).
  static int _lowestBitValue(int bit) {
    int v = 1;
    while (bit > 1) {
      bit >>= 1;
      v++;
    }
    return v;
  }
}
