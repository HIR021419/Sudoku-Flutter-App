import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/repositories/achievements_repository.dart';
import 'package:sudoku/repositories/daily_repository.dart';
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

@Riverpod(keepAlive: true)
DailyRepository dailyRepository(DailyRepositoryRef ref) =>
    SharedPrefsDailyRepository();

@Riverpod(keepAlive: true)
AchievementsRepository achievementsRepository(AchievementsRepositoryRef ref) =>
    SharedPrefsAchievementsRepository();
