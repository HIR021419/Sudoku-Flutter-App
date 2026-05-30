import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/repositories/game_repository.dart';
import 'package:sudoku/repositories/settings_repository.dart';
import 'package:sudoku/repositories/stats_repository.dart';

part 'repositories.g.dart';

/// Repositories exposés à l'app via Riverpod.
///
/// `keepAlive: true` car ce sont des singletons applicatifs : on ne veut pas
/// que Riverpod les recrée à chaque souscription/désouscription. Pour les
/// remplacer dans un test, utiliser `ProviderScope(overrides: [...])`.

@Riverpod(keepAlive: true)
GameRepository gameRepository(GameRepositoryRef ref) =>
    SharedPrefsGameRepository();

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(SettingsRepositoryRef ref) =>
    SharedPrefsSettingsRepository();

@Riverpod(keepAlive: true)
StatsRepository statsRepository(StatsRepositoryRef ref) =>
    SharedPrefsStatsRepository();
