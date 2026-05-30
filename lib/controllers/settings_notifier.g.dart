// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsNotifierHash() => r'081dd730961e462c4406563e9718324e68ed033a';

/// AsyncNotifier qui expose [Settings] et gère sa persistance.
///
/// Lecture initiale via `build()` (asynchrone, lazy au premier `ref.watch`).
/// Toute mutation passe par `update(...)` qui fait `state = AsyncData(newSettings)`
/// puis persiste en arrière-plan.
///
/// Copied from [SettingsNotifier].
@ProviderFor(SettingsNotifier)
final settingsNotifierProvider =
    AsyncNotifierProvider<SettingsNotifier, Settings>.internal(
      SettingsNotifier.new,
      name: r'settingsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$settingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SettingsNotifier = AsyncNotifier<Settings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
