import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/controllers/game_notifier.dart';
import 'package:sudoku/controllers/settings_notifier.dart';
import 'package:sudoku/controllers/stats_notifier.dart';
import 'package:sudoku/entities/settings.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/l10n/difficulty_l10n.dart';
import 'package:sudoku/models/game_state.dart';
import 'package:sudoku/models/sudoku_page_init.dart';
import 'package:sudoku/providers/repositories.dart';
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
      showWinDialog(
        context,
        duration: state.completedDuration ?? Duration.zero,
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

      // Pas de confirmation : on sauvegarde silencieusement la partie en
      // cours et on rend la main à l'accueil. Si la partie est complète,
      // `flushSave` appelle `repo.clear()` en interne (cf. GameNotifier).
      // La confirmation d'abandon reste sur HomePage quand on lance une
      // nouvelle partie alors qu'une est sauvegardée.
      await ref.read(gameNotifierProvider.notifier).flushSave();
      if (context.mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      exitFlowInProgress.value = false;
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
          ref.read(statsNotifierProvider.notifier).recordWin(
                next.session.difficulty,
                duration,
              );
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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        handleExitAttempt();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(state.session.difficulty.localizedLabel(context)),
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
