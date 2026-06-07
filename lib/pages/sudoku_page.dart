import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/controllers/achievements_notifier.dart';
import 'package:sudoku/controllers/daily_notifier.dart';
import 'package:sudoku/controllers/game_notifier.dart';
import 'package:sudoku/controllers/settings_notifier.dart';
import 'package:sudoku/controllers/stats_notifier.dart';
import 'package:sudoku/entities/settings.dart';
import 'package:sudoku/entities/type/achievement_id.dart';
import 'package:sudoku/l10n/achievement_l10n.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/l10n/difficulty_l10n.dart';
import 'package:sudoku/models/game_state.dart';
import 'package:sudoku/models/sudoku_page_init.dart';
import 'package:sudoku/providers/repositories.dart';
import 'package:sudoku/services/play_games_service.dart';
import 'package:sudoku/utils/daily_challenge.dart';
import 'package:sudoku/widgets/sudoku_dialogs.dart';
import 'package:sudoku/widgets/sudoku_layout.dart';

class SudokuPage extends HookConsumerWidget {
  const SudokuPage({super.key, required this.init});

  final SudokuPageInit init;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- Controllers locaux (lifecycle géré par les hooks) ---

    final shakeController = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );

    final confettiController = useMemoized(
      () => ConfettiController(duration: const Duration(seconds: 2)),
      const [],
    );
    useEffect(() => confettiController.dispose, [confettiController]);

    // --- State non-réactif (refs) ---
    // Mutés via .value, ne déclenchent PAS de rebuild — utile pour des flags
    // de coordination (debounces, transitions).

    final lastErrorCount = useRef(0);
    final wasComplete = useRef(false);
    final dialogShown = useRef(false);
    final exitFlowInProgress = useRef(false);

    // --- Helpers (closures sur le build) ---

    void showWinDialogNow() {
      final state = ref.read(gameNotifierProvider);
      if (state == null) return;
      final rawDuration = state.completedDuration ?? Duration.zero;
      showWinDialog(
        context,
        duration: rawDuration,
        effectiveDuration: state.session.effectiveTime(rawDuration),
        errors: state.session.errorCount,
        hints: state.session.hintsUsed,
        difficultyLabel: state.session.difficulty.localizedLabel(context),
        onBackHome: () {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        },
      );
    }

    Future<void> handleExitAttempt() async {
      if (exitFlowInProgress.value) return;
      exitFlowInProgress.value = true;
      try {
        // Défi du jour non terminé : on confirme l'abandon (message dédié) et,
        // si confirmé, on pose le verrou du jour (1 tentative). Une partie
        // normale est sauvegardée silencieusement (reprise possible).
        if (init is DailyGameInit &&
            !(ref.read(gameNotifierProvider)?.isComplete ?? false)) {
          final confirm = await showDailyAbandonDialog(context);
          if (!context.mounted || !confirm) return; // reste sur la page
          await ref.read(dailyChallengeProvider.notifier).recordAbandon();
          if (!context.mounted) return;
        }

        await ref.read(gameNotifierProvider.notifier).flushSave();
        if (context.mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      } finally {
        exitFlowInProgress.value = false;
      }
    }

    // --- Bootstrap : init le notifier après le premier frame ---

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!context.mounted) return;
        final notifier = ref.read(gameNotifierProvider.notifier);
        switch (init) {
          case NewGameInit():
            notifier.startFromGenerated(
              difficulty: (init as NewGameInit).difficulty,
              solution: (init as NewGameInit).solution,
              givens: (init as NewGameInit).givens,
            );
          case DailyGameInit():
            notifier.startDaily(
              solution: (init as DailyGameInit).solution,
              givens: (init as DailyGameInit).givens,
            );
          case RestoreGameInit():
            final ok = notifier.restoreFromJson(
              (init as RestoreGameInit).savedJson,
            );
            if (!ok) {
              await ref.read(gameRepositoryProvider).clear();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context).savedCorruptedSnackbar,
                  ),
                  duration: const Duration(seconds: 3),
                ),
              );
              if (context.mounted && Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
              return;
            }
        }
        // Capture l'état initial pour les détections de transition.
        final state = ref.read(gameNotifierProvider);
        if (state != null) {
          lastErrorCount.value = state.session.errorCount;
          wasComplete.value = state.isComplete;
        }
      });
      return null;
    }, const []);

    // --- AppLifecycle observer : flushSave on background ---
    //
    // On capture le notifier dans une variable locale du useEffect — il reste
    // accessible dans le cleanup même après dispose du widget. Tenter un
    // `ref.read(...)` dans le cleanup lève "Cannot use ref after the widget
    // was disposed" (hooks_riverpod garde-fou).
    useEffect(() {
      final notifier = ref.read(gameNotifierProvider.notifier);
      final observer = _AppLifecycleListener(notifier.flushSave);
      WidgetsBinding.instance.addObserver(observer);
      return () {
        WidgetsBinding.instance.removeObserver(observer);
        // Flush final quand la page est démontée (fire-and-forget).
        notifier.flushSave();
      };
    }, const []);

    // --- Listener sur le state pour transitions (erreurs, victoire) ---

    ref.listen<GameState?>(gameNotifierProvider, (previous, next) {
      if (next == null || !context.mounted) return;

      final hapticEnabled =
          ref.read(settingsNotifierProvider).valueOrNull?.hapticEnabled ??
          const Settings().hapticEnabled;

      final currentErrors = next.session.errorCount;
      if (currentErrors > lastErrorCount.value) {
        if (hapticEnabled) HapticFeedback.lightImpact();
        shakeController.forward(from: 0);
      }
      lastErrorCount.value = currentErrors;

      final nowComplete = next.isComplete;
      if (nowComplete && !wasComplete.value && !dialogShown.value) {
        dialogShown.value = true;
        if (hapticEnabled) HapticFeedback.heavyImpact();
        confettiController.play();
        final duration = next.completedDuration;
        if (duration != null) {
          // #10 — temps EFFECTIF (brut + pénalités erreurs/indices) : fait foi
          // pour le record et le classement.
          final effective = next.session.effectiveTime(duration);
          final session = next.session;
          final isDaily = init is DailyGameInit;

          // Notifiers/services capturés avant les `await` (évite l'usage de
          // `ref` après un éventuel dispose du widget).
          final statsNotifier = ref.read(statsNotifierProvider.notifier);
          final dailyNotifier = ref.read(dailyChallengeProvider.notifier);
          final achievements = ref.read(achievementsProvider.notifier);
          final playGames = ref.read(playGamesServiceProvider);

          // Enregistrement + évaluation des succès (#3) + envoi PGS (#2).
          // Fire-and-forget.
          () async {
            final List<AchievementId> unlocked;
            if (isDaily) {
              final dateKey = dailyDateKey(DateTime.now());
              await dailyNotifier.recordWin(
                effective,
                errorCount: session.errorCount,
                hintsUsed: session.hintsUsed,
              );
              unlocked = await achievements.onDailyWin(dateKey: dateKey);
              await playGames.submitDailyScore(effective);
            } else {
              await statsNotifier.recordWin(session.difficulty, effective);
              unlocked = await achievements.onGameWin(
                difficulty: session.difficulty,
                effectiveTime: effective,
                errorCount: session.errorCount,
                hintsUsed: session.hintsUsed,
              );
              await playGames.submitDifficultyScore(
                session.difficulty,
                effective,
              );
            }
            await playGames.unlockAchievements(unlocked);
            if (unlocked.isNotEmpty && context.mounted) {
              final names = unlocked
                  .map((id) => id.localizedTitle(context))
                  .join(', ');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context).achievementsUnlockedSnack(names),
                  ),
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          }();
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted &&
              (ref.read(gameNotifierProvider)?.isComplete ?? false)) {
            showWinDialogNow();
          }
        });
      } else if (!nowComplete && wasComplete.value) {
        dialogShown.value = false;
      }
      wasComplete.value = nowComplete;
    });

    // --- Render ---

    final state = ref.watch(gameNotifierProvider);
    if (state == null) {
      // Frame initiale, bootstrap en cours.
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        handleExitAttempt();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            init is DailyGameInit
                ? AppLocalizations.of(context).dailyTitle
                : state.session.difficulty.localizedLabel(context),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: handleExitAttempt,
          ),
        ),
        body: SudokuGameLayout(
          shakeController: shakeController,
          confettiController: confettiController,
        ),
      ),
    );
  }
}

/// Petit observer dédié au cycle de vie de l'app. Hookable via [useEffect]
/// car on ne peut pas faire `with WidgetsBindingObserver` sur un widget
/// fonctionnel (pas de State).
class _AppLifecycleListener extends WidgetsBindingObserver {
  _AppLifecycleListener(this.onBackground);

  final VoidCallback onBackground;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.hidden) {
      onBackground();
    }
  }
}
