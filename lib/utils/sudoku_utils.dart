import 'package:sudoku/entities/difficulty_enum.dart';
import 'dart:math';

class SudokuUtils {
  static final _random = Random();

  static List<int> generateGrid() {
    List<int> grid = List.filled(81, 0);
    _fillGrid(grid);
    return grid;
  }

  static bool _fillGrid(List<int> grid) {
    for (int i = 0; i < 81; i++) {
      if (grid[i] == 0) {
        List<int> numbers = List.generate(9, (i) => i + 1)..shuffle(_random);

        for (int number in numbers) {
          if (_isValid(grid, i, number)) {
            grid[i] = number;

            if (_fillGrid(grid)) {
              return true;
            }

            grid[i] = 0;
          }
        }
        return false;
      }
    }
    return true;
  }

  static bool _isValid(List<int> grid, int index, int value) {
    int row = index ~/ 9;
    int col = index % 9;

    // ligne
    for (int i = 0; i < 9; i++) {
      if (grid[row * 9 + i] == value) return false;
    }

    // colonne
    for (int i = 0; i < 9; i++) {
      if (grid[i * 9 + col] == value) return false;
    }

    // bloc 3x3
    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;

    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        if (grid[(startRow + r) * 9 + (startCol + c)] == value) {
          return false;
        }
      }
    }

    return true;
  }

  static List<int> generateGivens(List<int> grid, DifficultyEnum difficulty) {
    int clues;

    switch (difficulty) {
      case DifficultyEnum.easy:
        clues = 40;
        break;
      case DifficultyEnum.medium:
        clues = 32;
        break;
      case DifficultyEnum.hard:
        clues = 26;
        break;
      case DifficultyEnum.expert:
        clues = 22;
        break;
    }

    List<int> indices = List.generate(81, (i) => i)..shuffle(_random);

    List<int> givens = indices.take(clues).toList();

    return givens;
  }
}