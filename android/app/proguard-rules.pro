# Règles ProGuard / R8 spécifiques à l'app.
# Flutter fournit déjà des règles via flutter.jar / flutter_tools.
# Ajouter ici toute règle nécessaire à des plugins natifs non-couverts.

# Conserve les classes utilisées par shared_preferences et autres plugins MethodChannel.
-keep class androidx.lifecycle.** { *; }
