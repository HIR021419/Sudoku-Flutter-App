// Smoke test minimal — vérifie juste que l'app peut être instanciée
// avec des repositories en mémoire. Les vrais tests viendront dans une
// itération dédiée.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/providers/repositories.dart';
import 'package:sudoku/repositories/game_repository.dart';
import 'package:sudoku/repositories/settings_repository.dart';
import 'package:sudoku/repositories/stats_repository.dart';
import 'package:sudoku/sudoku_app.dart';

class _InMemoryGameRepository implements GameRepository {
  Map<String, dynamic>? _data;

  @override
  Future<Map<String, dynamic>?> loadSaved() async => _data;

  @override
  Future<void> save(Map<String, dynamic> data) async => _data = data;

  @override
  Future<void> clear() async => _data = null;
}

class _InMemoryMapRepository implements StatsRepository, SettingsRepository {
  Map<String, dynamic>? _data;

  @override
  Future<Map<String, dynamic>?> load() async => _data;

  @override
  Future<void> save(Map<String, dynamic> data) async => _data = data;
}

void main() {
  testWidgets('App boots without a saved game', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gameRepositoryProvider.overrideWithValue(_InMemoryGameRepository()),
          settingsRepositoryProvider.overrideWithValue(
            _InMemoryMapRepository(),
          ),
          statsRepositoryProvider.overrideWithValue(_InMemoryMapRepository()),
        ],
        child: const SudokuApp(),
      ),
    );
    await tester.pumpAndSettle();
    // L'app a démarré : on doit trouver au moins le sélecteur de difficulté.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
