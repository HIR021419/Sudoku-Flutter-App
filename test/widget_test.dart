// Smoke test minimal — vérifie juste que l'app peut être instanciée
// avec un repository en mémoire. Les vrais tests viendront dans une itération dédiée.

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/data/game_repository.dart';
import 'package:sudoku/sudoku_app.dart';

class _InMemoryRepository implements GameRepository {
  Map<String, dynamic>? _data;

  @override
  Future<Map<String, dynamic>?> loadSaved() async => _data;

  @override
  Future<void> save(Map<String, dynamic> data) async {
    _data = data;
  }

  @override
  Future<void> clear() async {
    _data = null;
  }
}

void main() {
  testWidgets('App boots without a saved game', (tester) async {
    await tester.pumpWidget(SudokuApp(repository: _InMemoryRepository()));
    await tester.pumpAndSettle();
    expect(find.text('Sudoku'), findsOneWidget);
  });
}
