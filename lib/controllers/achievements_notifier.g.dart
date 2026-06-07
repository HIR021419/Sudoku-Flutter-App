// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievements_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$achievementsHash() => r'4f0ee04c207206bdf5380a2fa91df8c2113d7033';

/// Moteur de succès (#3). Source de vérité **locale** (fonctionne hors-ligne) ;
/// en Phase 5 (PGS), pousser les déblocages vers l'API Achievements.
///
/// Les méthodes `onGameWin`/`onDailyWin` retournent la liste des succès
/// **nouvellement** débloqués (pour le retour UI).
///
/// Copied from [Achievements].
@ProviderFor(Achievements)
final achievementsProvider =
    AsyncNotifierProvider<Achievements, AchievementsState>.internal(
      Achievements.new,
      name: r'achievementsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$achievementsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Achievements = AsyncNotifier<AchievementsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
