import 'package:flutter/material.dart';

/// `ScrollBehavior` qui supprime totalement la scrollbar.
///
/// À appliquer via `ScrollConfiguration(behavior: const NoScrollbarBehavior(),
/// child: ...)` autour d'un `SingleChildScrollView`, `ListView`, `GridView`,
/// etc. dont on ne veut afficher aucun indicateur de défilement (cas typiques :
/// contenu qui tient à l'écran, ou esthétique épurée).
///
/// Override uniquement `buildScrollbar` — la sémantique de défilement reste
/// celle de la plateforme.
class NoScrollbarBehavior extends ScrollBehavior {
  const NoScrollbarBehavior();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;
}
