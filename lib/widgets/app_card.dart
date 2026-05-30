import 'package:flutter/material.dart';

/// Carte Material réutilisable avec un `borderRadius` de 14 px.
///
/// - [color] : couleur de fond. Si null, utilise `surfaceContainerLow` (défaut).
/// - [onTap] : si non-null, enveloppe [child] dans un [InkWell].
///
/// Remplace le pattern répété `Material + borderRadius(14)` dans :
/// `settings_page.dart` (anciennement `_SectionCard`),
/// `stats_card_widget.dart`, `resume_game_card.dart`.
class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.color, this.onTap});

  final Widget child;
  final Color? color;
  final VoidCallback? onTap;

  static const _radius = BorderRadius.all(Radius.circular(14));

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? Theme.of(context).colorScheme.surfaceContainerLow;
    return Material(
      color: effectiveColor,
      borderRadius: _radius,
      child: onTap != null
          ? InkWell(borderRadius: _radius, onTap: onTap, child: child)
          : child,
    );
  }
}
