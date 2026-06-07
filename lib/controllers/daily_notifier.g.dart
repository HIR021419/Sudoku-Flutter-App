// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dailyChallengeHash() => r'52bea8ab956ac082250bd8deb67ceaecc3f01914';

/// Défi du jour (#1). Verrou posé **uniquement** après victoire ou abandon
/// explicite. `keepAlive` pour conserver l'état pendant la navigation
/// home → grille → home.
///
/// Copied from [DailyChallenge].
@ProviderFor(DailyChallenge)
final dailyChallengeProvider =
    AsyncNotifierProvider<DailyChallenge, DailyState>.internal(
      DailyChallenge.new,
      name: r'dailyChallengeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dailyChallengeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DailyChallenge = AsyncNotifier<DailyState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
