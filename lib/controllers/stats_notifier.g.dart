// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statsNotifierHash() => r'dc0045e4d036e086f293b4fd5ac1549b8fd433ce';

/// AsyncNotifier qui expose les [Stats] et gère leur persistance.
///
/// Stratégie de migration **stricte** : si le blob est inconnu/corrompu,
/// on retombe sur `Stats.empty()` (perte des stats acceptée).
///
/// Copied from [StatsNotifier].
@ProviderFor(StatsNotifier)
final statsNotifierProvider =
    AsyncNotifierProvider<StatsNotifier, Stats>.internal(
      StatsNotifier.new,
      name: r'statsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$statsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$StatsNotifier = AsyncNotifier<Stats>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
