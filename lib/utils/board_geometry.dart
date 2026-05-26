/// Géométrie du plateau Sudoku 9×9.
///
/// Toutes les fonctions opèrent sur un index linéaire dans [0..80],
/// où `index = row * 9 + col`.

/// Ligne de la cellule à [index] (0-based).
int rowOf(int index) => index ~/ 9;

/// Colonne de la cellule à [index] (0-based).
int colOf(int index) => index % 9;

/// Numéro de bloc 3×3 de la cellule à [index] (0-based, ligne-major).
int boxOf(int index) => (index ~/ 9 ~/ 3) * 3 + (index % 9 ~/ 3);

/// Indices de toutes les cellules partageant la même ligne, colonne ou bloc
/// que [index], en excluant [index] lui-même.
Iterable<int> peerIndexesOf(int index) sync* {
  final row = rowOf(index);
  final col = colOf(index);
  final boxRow = (row ~/ 3) * 3;
  final boxCol = (col ~/ 3) * 3;
  final seen = <int>{index};

  for (int i = 0; i < 9; i++) {
    final r = row * 9 + i;
    final c = i * 9 + col;
    if (seen.add(r)) yield r;
    if (seen.add(c)) yield c;
  }
  for (int r = 0; r < 3; r++) {
    for (int c = 0; c < 3; c++) {
      final idx = (boxRow + r) * 9 + (boxCol + c);
      if (seen.add(idx)) yield idx;
    }
  }
}
