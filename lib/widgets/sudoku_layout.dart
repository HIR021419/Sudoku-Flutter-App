import 'dart:math' as math;
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/widgets/game_toolbar_widget.dart';
import 'package:sudoku/widgets/number_pad_widget.dart';
import 'package:sudoku/widgets/sudoku_grid_widget.dart';

/// Body de la page de jeu : gère l'orientation portrait/paysage,
/// l'animation de secousse de la grille et l'overlay confetti.
///
/// Les deux contrôleurs sont owned par [_SudokuPageState] (cycle de vie),
/// ce widget n'en fait que la présentation.
class SudokuGameLayout extends StatelessWidget {
  const SudokuGameLayout({
    super.key,
    required this.shakeController,
    required this.confettiController,
  });

  final AnimationController shakeController;
  final ConfettiController confettiController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape =
                  constraints.maxWidth > constraints.maxHeight * 1.1;
              final grid = _ShakingGrid(controller: shakeController);
              return Padding(
                padding: const EdgeInsets.all(12),
                child: isLandscape
                    ? _buildLandscape(grid)
                    : _buildPortrait(grid),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: confettiController,
            blastDirection: math.pi / 2,
            blastDirectionality: BlastDirectionality.explosive,
            maxBlastForce: 25,
            minBlastForce: 10,
            emissionFrequency: 0.05,
            numberOfParticles: 25,
            gravity: 0.25,
            shouldLoop: false,
            colors: const [
              Color(0xFF4F46E5),
              Color(0xFF3B82F6),
              Color(0xFFF59E0B),
              Color(0xFF10B981),
              Color(0xFFEC4899),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPortrait(_ShakingGrid grid) {
    return Column(
      children: [
        Expanded(child: Center(child: grid)),
        const SizedBox(height: 16),
        const GameToolbarWidget(),
        const SizedBox(height: 12),
        const NumberPadWidget(),
      ],
    );
  }

  Widget _buildLandscape(_ShakingGrid grid) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 5, child: Center(child: grid)),
        const SizedBox(width: 16),
        const Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GameToolbarWidget(),
              SizedBox(height: 20),
              NumberPadWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

/// Grille Sudoku avec animation de secousse horizontale sur erreur.
class _ShakingGrid extends StatelessWidget {
  const _ShakingGrid({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final t = controller.value;
        final dx = t == 0 ? 0.0 : math.sin(t * 4 * math.pi) * (1 - t) * 8;
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
      child: const AspectRatio(aspectRatio: 1, child: SudokuGridWidget()),
    );
  }
}
