import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/l10n/difficulty_l10n.dart';
import 'package:sudoku/models/game_controller.dart';
import 'package:sudoku/widgets/game_toolbar_widget.dart';
import 'package:sudoku/widgets/number_pad_widget.dart';
import 'package:sudoku/widgets/sudoku_grid_widget.dart';

class SudokuPage extends StatefulWidget {
  const SudokuPage({super.key, required this.controller});

  final GameController controller;

  @override
  State<SudokuPage> createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> with WidgetsBindingObserver {
  late final GameController _controller;
  int _lastErrorCount = 0;
  bool _wasComplete = false;
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _lastErrorCount = _controller.errorCount;
    _wasComplete = _controller.isComplete;
    _controller.addListener(_onControllerChanged);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.removeListener(_onControllerChanged);
    // Flush synchronously avant disposal pour que les derniers coups soient sauvegardés.
    _controller.flushSave();
    _controller.dispose();
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

    // Haptique sur erreur (sans bloquer l'UI).
    final currentErrors = _controller.errorCount;
    if (currentErrors > _lastErrorCount) {
      HapticFeedback.lightImpact();
    }
    _lastErrorCount = currentErrors;

    // Détection de transition isComplete pour gérer le dialog re-armable.
    final nowComplete = _controller.isComplete;
    if (nowComplete && !_wasComplete && !_dialogShown) {
      _dialogShown = true;
      HapticFeedback.heavyImpact();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _controller.isComplete) _showWinDialog();
      });
    } else if (!nowComplete && _wasComplete) {
      // Undo après win → on re-arme le dialog pour la prochaine victoire.
      _dialogShown = false;
    }
    _wasComplete = nowComplete;
  }

  void _showWinDialog() {
    final duration = _controller.completedDuration ?? Duration.zero;
    final errors = _controller.errorCount;
    final hints = _controller.hintsUsed;
    final pageContext = context;
    final l10n = AppLocalizations.of(pageContext);
    final difficultyLabel = _controller.difficulty.localizedLabel(pageContext);

    showDialog(
      context: pageContext,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          icon: Icon(
            Icons.emoji_events,
            color: Theme.of(dialogContext).colorScheme.primary,
            size: 48,
          ),
          title: Text(l10n.winTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.winSubtitle(difficultyLabel),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _WinStat(
                    icon: Icons.timer_outlined,
                    label: l10n.winStatTime,
                    value: _formatDuration(duration),
                  ),
                  _WinStat(
                    icon: Icons.error_outline_rounded,
                    label: l10n.winStatErrors,
                    value: '$errors',
                  ),
                  _WinStat(
                    icon: Icons.lightbulb_outline_rounded,
                    label: l10n.winStatHints,
                    value: '$hints',
                  ),
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (Navigator.of(pageContext).canPop()) {
                  Navigator.of(pageContext).pop();
                }
              },
              child: Text(l10n.winBackHome),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;
    final mm = minutes.toString().padLeft(2, '0');
    final ss = seconds.toString().padLeft(2, '0');
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$mm:$ss';
    }
    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameController>.value(
      value: _controller,
      child: PopScope(
        canPop: !_controller.isComplete,
        onPopInvokedWithResult: (didPop, result) {
          // Force flush si l'utilisateur sort autrement (back gesture).
          if (didPop) _controller.flushSave();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(_controller.difficulty.localizedLabel(context)),
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape =
                    constraints.maxWidth > constraints.maxHeight * 1.1;
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: isLandscape ? _buildLandscape() : _buildPortrait(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPortrait() {
    return Column(
      children: const [
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: SudokuGridWidget(),
            ),
          ),
        ),
        SizedBox(height: 16),
        GameToolbarWidget(),
        SizedBox(height: 12),
        NumberPadWidget(),
      ],
    );
  }

  Widget _buildLandscape() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Expanded(
          flex: 5,
          child: Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: SudokuGridWidget(),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
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

class _WinStat extends StatelessWidget {
  const _WinStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: colorScheme.onPrimaryContainer, size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
