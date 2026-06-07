# Règles ProGuard / R8 spécifiques à l'app.
# Flutter fournit déjà des règles via flutter.jar / flutter_tools.
# Ajouter ici toute règle nécessaire à des plugins natifs non-couverts.

# Flutter engine & plugins (MethodChannel, EventChannel, platform views…)
-keep class io.flutter.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.embedding.** { *; }

# Play Core Split Install — référencé par FlutterPlayStoreSplitApplication mais
# non utilisé (pas de deferred components). Supprimer les warnings R8.
-dontwarn com.google.android.play.core.**

# shared_preferences
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-keep class androidx.datastore.** { *; }

# Lifecycle (requis par plusieurs plugins AndroidX)
-keep class androidx.lifecycle.** { *; }
