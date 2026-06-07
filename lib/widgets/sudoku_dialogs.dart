import 'package:flutter/material.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/utils/game_formatters.dart';

/// Affiche le dialog de victoire. Non dismissable par le back-gesture.
///
/// [onBackHome] est appelé après fermeture du dialog pour revenir à l'accueil.
Future<void> showWinDialog(
  BuildContext context, {
  required Duration duration,
  required Duration effectiveDuration,
  required int errors,
  required int hints,
  required String difficultyLabel,
  required VoidCallback onBackHome,
}) {
  final l10n = AppLocalizations.of(context);
  // #10 — temps retenu (brut + pénalités) affiché seulement s'il diffère du
  // temps brut, i.e. s'il y a eu des erreurs et/ou des indices.
  final hasPenalty = effectiveDuration > duration;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => PopScope(
      canPop: false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                WinStat(
                  icon: Icons.timer_outlined,
                  label: l10n.winStatTime,
                  value: formatDuration(duration),
                ),
                WinStat(
                  icon: Icons.error_outline_rounded,
                  label: l10n.winStatErrors,
                  value: '$errors',
                ),
                WinStat(
                  icon: Icons.lightbulb_outline_rounded,
                  label: l10n.winStatHints,
                  value: '$hints',
                ),
              ],
            ),
            if (hasPenalty) ...[
              const SizedBox(height: 16),
              Text(
                l10n.winEffectiveTime(formatDuration(effectiveDuration)),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(dialogContext).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onBackHome();
            },
            child: Text(l10n.winBackHome),
          ),
        ],
      ),
    ),
  );
}

/// Affiche le dialog de confirmation d'abandon de partie.
/// Retourne true si l'utilisateur confirme, false sinon.
Future<bool> showAbandonDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.leaveGameTitle),
      content: Text(l10n.leaveGameMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(l10n.leaveGameCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(l10n.leaveGameConfirm),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Variante pour le **défi du jour** : message dédié (la tentative du jour est
/// perdue, pas de reprise). Retourne true si l'utilisateur confirme.
Future<bool> showDailyAbandonDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.dailyAbandonTitle),
      content: Text(l10n.dailyAbandonMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(l10n.leaveGameCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(l10n.leaveGameConfirm),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Stat individuelle affichée dans le dialog de victoire.
class WinStat extends StatelessWidget {
  const WinStat({
    super.key,
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
    final l10n = AppLocalizations.of(context);
    // MergeSemantics : un seul nœud a11y "label: value" au lieu de 3 lectures
    // séparées (icône / valeur / label). L'icône est purement décorative.
    return Semantics(
      label: l10n.winStatSemanticLabel(label, value),
      excludeSemantics: true,
      child: Column(
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
