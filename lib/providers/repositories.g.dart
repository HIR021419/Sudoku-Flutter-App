// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repositories.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameRepositoryHash() => r'42d3d7af96f1eb5be58a0432251a7c4ff8a76266';

/// Repositories exposés à l'app via Riverpod.
///
/// `keepAlive: true` car ce sont des singletons applicatifs : on ne veut pas
/// que Riverpod les recrée à chaque souscription/désouscription. Pour les
/// remplacer dans un test, utiliser `ProviderScope(overrides: [...])`.
///
/// Copied from [gameRepository].
@ProviderFor(gameRepository)
final gameRepositoryProvider = Provider<GameRepository>.internal(
  gameRepository,
  name: r'gameRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GameRepositoryRef = ProviderRef<GameRepository>;
String _$settingsRepositoryHash() =>
    r'6444d0c767d80f7dd332a21c95d7fded71c93a9f';

/// See also [settingsRepository].
@ProviderFor(settingsRepository)
final settingsRepositoryProvider = Provider<SettingsRepository>.internal(
  settingsRepository,
  name: r'settingsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsRepositoryRef = ProviderRef<SettingsRepository>;
String _$statsRepositoryHash() => r'58f0f506ed292096decc6f37cb714ae54712bd49';

/// See also [statsRepository].
@ProviderFor(statsRepository)
final statsRepositoryProvider = Provider<StatsRepository>.internal(
  statsRepository,
  name: r'statsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsRepositoryRef = ProviderRef<StatsRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
