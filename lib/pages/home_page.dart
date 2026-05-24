import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/data/game_repository.dart';
import 'package:sudoku/entities/difficulty_enum.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/models/game_controller.dart';
import 'package:sudoku/pages/settings_page.dart';
import 'package:sudoku/pages/sudoku_page.dart';
import 'package:sudoku/utils/sudoku_utils.dart';
import 'package:sudoku/widgets/difficulty_selector_widget.dart';
import 'package:sudoku/widgets/resume_game_card.dart';
import 'package:sudoku/widgets/stats_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.repository,
    this.initialSaved,
  });

  final GameRepository repository;
  final Map<String, dynamic>? initialSaved;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? _saved;
  bool _navigating = false;
  bool _generating = false;

  @override
  void initState() {
    super.initState();
    _saved = widget.initialSaved;
  }

  Future<void> _navigateToGame(GameController controller) async {
    if (_navigating) {
      controller.dispose();
      return;
    }
    _navigating = true;
    try {
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SudokuPage(controller: controller)),
      );
    } finally {
      _navigating = false;
    }
    if (!mounted) return;
    final updated = await widget.repository.loadSaved();
    if (!mounted) return;
    setState(() => _saved = updated);
  }

  Future<void> _onResume() async {
    if (_navigating) return;
    final saved = _saved;
    if (saved == null) return;

    final controller = GameController(repository: widget.repository);
    final ok = controller.restoreFromJson(saved);
    if (!ok) {
      controller.dispose();
      await widget.repository.clear();
      if (!mounted) return;
      setState(() => _saved = null);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).savedCorruptedSnackbar),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }
    await _navigateToGame(controller);
  }

  Future<void> _onPlay(DifficultyEnum difficulty) async {
    if (_navigating || _generating) return;
    setState(() => _generating = true);
    try {
      // Génération en isolate pour ne pas bloquer l'UI (surtout en Expert
      // où l'unicité de solution peut prendre quelques secondes).
      final puzzle = await compute(generatePuzzleData, difficulty);
      if (!mounted) return;
      final controller = GameController(repository: widget.repository);
      controller.initFromGenerated(
        difficulty: difficulty,
        solution: puzzle.solution,
        givens: puzzle.givens,
      );
      await _navigateToGame(controller);
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final saved = _saved;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        actions: [
          IconButton(
            tooltip: AppLocalizations.of(context).settingsTitle,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                          color: colorScheme.primary.withValues(alpha: 0.3),
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
                  if (saved != null) ...[
                    ResumeGameCard(
                      saved: saved,
                      onTap: _generating ? null : _onResume,
                    ),
                    const SizedBox(height: 24),
                  ],
                  DifficultySelectorWidget(
                    onPlay: _onPlay,
                    isLoading: _generating,
                  ),
                  const SizedBox(height: 24),
                  const StatsCardWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
