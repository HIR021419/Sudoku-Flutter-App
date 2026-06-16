// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameNotifierHash() => r'120a966cc7ab12f20cc77942cfc3bfb6028e41ee';

/// Notifier autoDispose qui pilote l'état d'une partie.
///
/// State **nullable** : `null` jusqu'à ce que la page appelle
/// `startFromGenerated()` ou `restoreFromJson()` en `initState`. L'UI affiche
/// un loader pendant cette frame initiale.
///
/// Lifecycle : le runtime (Stopwatch + Timer de save) est libéré via
/// `ref.onDispose`, déclenché par Riverpod quand la page quitte l'écran.
///
/// Copied from [GameNotifier].
@ProviderFor(GameNotifier)
final gameNotifierProvider =
    AutoDisposeNotifierProvider<GameNotifier, GameState?>.internal(
      GameNotifier.new,
      name: r'gameNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gameNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GameNotifier = AutoDisposeNotifier<GameState?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
