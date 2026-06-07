import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/entities/type/difficulty_enum.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/models/sudoku_page_init.dart';
import 'package:sudoku/pages/achievements_page.dart';
import 'package:sudoku/pages/settings_page.dart';
import 'package:sudoku/pages/sudoku_page.dart';
import 'package:sudoku/widgets/sudoku_dialogs.dart';
import 'package:sudoku/providers/repositories.dart';
import 'package:sudoku/services/play_games_service.dart';
import 'package:sudoku/utils/daily_challenge.dart';
import 'package:sudoku/utils/scroll_behaviors.dart';
import 'package:sudoku/utils/sudoku_utils.dart';
import 'package:sudoku/widgets/daily_card.dart';
import 'package:sudoku/widgets/difficulty_selector_widget.dart';
import 'package:sudoku/widgets/resume_game_card.dart';
import 'package:sudoku/widgets/stats_card_widget.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key, this.initialSaved});

  final Map<String, dynamic>? initialSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    // `saved` est un useState car son changement doit déclencher un rebuild
    // (affichage ou non du ResumeGameCard). Les deux flags `navigating` /
    // `generating` sont utilisés pour gérer les transitions UI.
    final saved = useState<Map<String, dynamic>?>(initialSaved);
    final navigating = useState(false);
    final generating = useState(false);

    // Connexion Play Games silencieuse au démarrage (best-effort, #2).
    useEffect(() {
      ref.read(playGamesServiceProvider).trySilentSignIn();
      return null;
    }, const []);

    Future<void> pushSudokuPage(SudokuPageInit init) async {
      if (navigating.value) return;
      navigating.value = true;
      try {
        await Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => SudokuPage(init: init)));
      } finally {
        navigating.value = false;
      }
      if (!context.mounted) return;
      final updated = await ref.read(gameRepositoryProvider).loadSaved();
      if (!context.mounted) return;
      saved.value = updated;
    }

    Future<void> onResume() async {
      if (navigating.value) return;
      final current = saved.value;
      if (current == null) return;
      await pushSudokuPage(RestoreGameInit(savedJson: current));
    }

    Future<void> onPlay(DifficultyEnum difficulty) async {
      if (navigating.value || generating.value) return;

      // Confirmation d'abandon si partie en cours.
      if (saved.value != null) {
        final shouldAbandon = await showAbandonDialog(context);
        if (!context.mounted || !shouldAbandon) return;
        await ref.read(gameRepositoryProvider).clear();
        if (!context.mounted) return;
        saved.value = null;
      }

      generating.value = true;
      try {
        // Génération en isolate pour ne pas bloquer l'UI (surtout en Expert).
        final puzzle = await compute(generatePuzzleData, difficulty);
        if (!context.mounted) return;
        await pushSudokuPage(
          NewGameInit(
            difficulty: difficulty,
            solution: puzzle.solution,
            givens: puzzle.givens,
          ),
        );
      } finally {
        if (context.mounted) generating.value = false;
      }
    }

    Future<void> onPlayDaily() async {
      if (navigating.value || generating.value) return;
      generating.value = true;
      try {
        // Grille déterministe du jour (UTC) — identique pour tous les joueurs.
        final seed = dailySeed(DateTime.now());
        final puzzle = await compute(
          generateSeededPuzzleData,
          (dailyDifficulty, seed),
        );
        if (!context.mounted) return;
        // Pas de verrou au lancement : il est posé seulement à la victoire ou
        // sur abandon explicite (cf. SudokuPage). Le défi ne touche pas le
        // slot de sauvegarde normal (pas de reprise).
        await pushSudokuPage(
          DailyGameInit(solution: puzzle.solution, givens: puzzle.givens),
        );
      } finally {
        if (context.mounted) generating.value = false;
      }
    }

    void openSettings() {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
    }

    void openAchievements() {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const AchievementsPage()));
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: ScrollConfiguration(
                behavior: const NoScrollbarBehavior(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.grid_on,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context).appTitle,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        if (saved.value != null) ...[
                          ResumeGameCard(
                            saved: saved.value!,
                            onTap: generating.value ? null : onResume,
                          ),
                          const SizedBox(height: 24),
                        ],
                        DailyCard(
                          onPlay: onPlayDaily,
                          isLoading: generating.value,
                        ),
                        const SizedBox(height: 16),
                        DifficultySelectorWidget(
                          onPlay: onPlay,
                          isLoading: generating.value,
                        ),
                        const SizedBox(height: 24),
                        const StatsCardWidget(),
                        const SizedBox(height: 12),
                        TextButton.icon(
                          onPressed: () => ref
                              .read(playGamesServiceProvider)
                              .showLeaderboards(),
                          icon: const Icon(Icons.leaderboard_outlined),
                          label: Text(
                            AppLocalizations.of(context).leaderboardsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  tooltip: AppLocalizations.of(context).settingsTitle,
                  iconSize: 30,
                  padding: const EdgeInsets.all(10),
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: openSettings,
                ),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  tooltip: AppLocalizations.of(context).achievementsTitle,
                  iconSize: 30,
                  padding: const EdgeInsets.all(10),
                  icon: const Icon(Icons.emoji_events_outlined),
                  onPressed: openAchievements,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

