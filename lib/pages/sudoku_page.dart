import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/l10n/difficulty_l10n.dart';
import 'package:sudoku/controllers/game_controller.dart';
import 'package:sudoku/controllers/settings_controller.dart';
import 'package:sudoku/controllers/stats_controller.dart';
import 'package:sudoku/pages/sudoku_dialogs.dart';
import 'package:sudoku/pages/sudoku_layout.dart';

class SudokuPage extends StatefulWidget {
  const SudokuPage({super.key, required this.controller});

  final GameController controller;

  @override
  State<SudokuPage> createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late final GameController _controller;
  late final AnimationController _shakeController;
  late final ConfettiController _confettiController;
  int _lastErrorCount = 0;
  bool _wasComplete = false;
  bool _dialogShown = false;
  bool _exitFlowInProgress = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _lastErrorCount = _controller.errorCount;
    _wasComplete = _controller.isComplete;
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    _controller.addListener(_onControllerChanged);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.removeListener(_onControllerChanged);
    _controller.flushSave();
    _controller.dispose();
    _shakeController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.hidden) {
      _controller.flushSave();
    }
  }

  void _onControllerChanged() {
    if (!mounted) return;

    final hapticEnabled =
        context.read<SettingsController>().settings.hapticEnabled;

    final currentErrors = _controller.errorCount;
    if (currentErrors > _lastErrorCount) {
      if (hapticEnabled) HapticFeedback.lightImpact();
      _shakeController.forward(from: 0);
    }
    _lastErrorCount = currentErrors;

    final nowComplete = _controller.isComplete;
    if (nowComplete && !_wasComplete && !_dialogShown) {
      _dialogShown = true;
      if (hapticEnabled) HapticFeedback.heavyImpact();
      _confettiController.play();
      final duration = _controller.completedDuration;
      if (duration != null) {
        context.read<StatsController>().recordWin(
          _controller.difficulty,
          duration,
        );
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _controller.isComplete) _showWinDialog();
      });
    } else if (!nowComplete && _wasComplete) {
      _dialogShown = false;
    }
    _wasComplete = nowComplete;
  }

  void _showWinDialog() {
    showWinDialog(
      context,
      duration: _controller.completedDuration ?? Duration.zero,
      errors: _controller.errorCount,
      hints: _controller.hintsUsed,
      difficultyLabel: _controller.difficulty.localizedLabel(context),
      onBackHome: () {
        if (mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  Future<void> _handleExitAttempt() async {
    if (_exitFlowInProgress) return;
    _exitFlowInProgress = true;

    if (_controller.isComplete) {
      await _controller.flushSave();
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      _exitFlowInProgress = false;
      return;
    }

    final shouldAbandon = await showAbandonDialog(context);
    if (!mounted || !shouldAbandon) {
      _exitFlowInProgress = false;
      return;
    }

    await _controller.abandonGame();
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    _exitFlowInProgress = false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameController>.value(
      value: _controller,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          _handleExitAttempt();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(_controller.difficulty.localizedLabel(context)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _handleExitAttempt,
            ),
          ),
          body: SudokuGameLayout(
            shakeController: _shakeController,
            confettiController: _confettiController,
          ),
        ),
      ),
    );
  }
}
