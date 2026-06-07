import 'package:flutter/foundation.dart';
import 'package:games_services/games_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/entities/type/achievement_id.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/services/play_games_config.dart';

part 'play_games_service.g.dart';

/// Wrapper **best-effort** autour de Google Play Games Services (#2).
///
/// Aucune opération n'interrompt le jeu : toute erreur (non connecté, IDs non
/// configurés, plateforme non supportée — iOS plus tard) est avalée. Le reste
/// de l'app ne dépend que de cette interface, pas du SDK.
class PlayGamesService {
  Future<bool> get isSignedIn async {
    try {
      return await GamesServices.isSignedIn;
    } catch (_) {
      return false;
    }
  }

  /// Connexion silencieuse (PGS v2 : automatique sur Android). À appeler au
  /// démarrage. Sans effet si déjà connecté ou indisponible.
  Future<void> trySilentSignIn() async {
    try {
      await GamesServices.signIn();
    } catch (e) {
      debugPrint('PGS signIn skipped: $e');
    }
  }

  /// Soumet le temps effectif (ms) au classement d'une difficulté.
  Future<void> submitDifficultyScore(
    DifficultyEnum difficulty,
    Duration effectiveTime,
  ) => _submit(
    PlayGamesConfig.leaderboardByDifficulty[difficulty],
    effectiveTime,
  );

  /// Soumet le temps effectif (ms) au classement du défi du jour.
  Future<void> submitDailyScore(Duration effectiveTime) =>
      _submit(PlayGamesConfig.dailyLeaderboard, effectiveTime);

  Future<void> _submit(String? leaderboardId, Duration effectiveTime) async {
    if (PlayGamesConfig.isPlaceholder(leaderboardId)) return;
    try {
      if (!await isSignedIn) return;
      await GamesServices.submitScore(
        score: Score(
          androidLeaderboardID: leaderboardId!,
          value: effectiveTime.inMilliseconds,
        ),
      );
    } catch (e) {
      debugPrint('PGS submitScore failed: $e');
    }
  }

  /// Pousse les succès débloqués localement vers PGS (Phase 4 → 5).
  Future<void> unlockAchievements(List<AchievementId> ids) async {
    if (ids.isEmpty) return;
    try {
      if (!await isSignedIn) return;
      for (final id in ids) {
        final pgId = PlayGamesConfig.achievementIds[id];
        if (PlayGamesConfig.isPlaceholder(pgId)) continue;
        await GamesServices.unlock(
          achievement: Achievement(androidID: pgId!, percentComplete: 100),
        );
      }
    } catch (e) {
      debugPrint('PGS unlock failed: $e');
    }
  }

  /// Ouvre l'UI native des classements (rang + onglet amis). Tente une
  /// connexion interactive si nécessaire.
  Future<void> showLeaderboards() async {
    try {
      if (!await isSignedIn) await GamesServices.signIn();
      await GamesServices.showLeaderboards();
    } catch (e) {
      debugPrint('PGS showLeaderboards failed: $e');
    }
  }
}

@Riverpod(keepAlive: true)
PlayGamesService playGamesService(PlayGamesServiceRef ref) =>
    PlayGamesService();
