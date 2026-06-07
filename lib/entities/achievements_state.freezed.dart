// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievements_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AchievementsState {

 Set<AchievementId> get unlocked; int get dailyStreak; String? get lastDailyWinDateKey;
/// Create a copy of AchievementsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementsStateCopyWith<AchievementsState> get copyWith => _$AchievementsStateCopyWithImpl<AchievementsState>(this as AchievementsState, _$identity);

  /// Serializes this AchievementsState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchievementsState&&const DeepCollectionEquality().equals(other.unlocked, unlocked)&&(identical(other.dailyStreak, dailyStreak) || other.dailyStreak == dailyStreak)&&(identical(other.lastDailyWinDateKey, lastDailyWinDateKey) || other.lastDailyWinDateKey == lastDailyWinDateKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(unlocked),dailyStreak,lastDailyWinDateKey);

@override
String toString() {
  return 'AchievementsState(unlocked: $unlocked, dailyStreak: $dailyStreak, lastDailyWinDateKey: $lastDailyWinDateKey)';
}


}

/// @nodoc
abstract mixin class $AchievementsStateCopyWith<$Res>  {
  factory $AchievementsStateCopyWith(AchievementsState value, $Res Function(AchievementsState) _then) = _$AchievementsStateCopyWithImpl;
@useResult
$Res call({
 Set<AchievementId> unlocked, int dailyStreak, String? lastDailyWinDateKey
});




}
/// @nodoc
class _$AchievementsStateCopyWithImpl<$Res>
    implements $AchievementsStateCopyWith<$Res> {
  _$AchievementsStateCopyWithImpl(this._self, this._then);

  final AchievementsState _self;
  final $Res Function(AchievementsState) _then;

/// Create a copy of AchievementsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unlocked = null,Object? dailyStreak = null,Object? lastDailyWinDateKey = freezed,}) {
  return _then(_self.copyWith(
unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as Set<AchievementId>,dailyStreak: null == dailyStreak ? _self.dailyStreak : dailyStreak // ignore: cast_nullable_to_non_nullable
as int,lastDailyWinDateKey: freezed == lastDailyWinDateKey ? _self.lastDailyWinDateKey : lastDailyWinDateKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AchievementsState].
extension AchievementsStatePatterns on AchievementsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchievementsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchievementsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchievementsState value)  $default,){
final _that = this;
switch (_that) {
case _AchievementsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchievementsState value)?  $default,){
final _that = this;
switch (_that) {
case _AchievementsState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<AchievementId> unlocked,  int dailyStreak,  String? lastDailyWinDateKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchievementsState() when $default != null:
return $default(_that.unlocked,_that.dailyStreak,_that.lastDailyWinDateKey);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<AchievementId> unlocked,  int dailyStreak,  String? lastDailyWinDateKey)  $default,) {final _that = this;
switch (_that) {
case _AchievementsState():
return $default(_that.unlocked,_that.dailyStreak,_that.lastDailyWinDateKey);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<AchievementId> unlocked,  int dailyStreak,  String? lastDailyWinDateKey)?  $default,) {final _that = this;
switch (_that) {
case _AchievementsState() when $default != null:
return $default(_that.unlocked,_that.dailyStreak,_that.lastDailyWinDateKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AchievementsState extends AchievementsState {
  const _AchievementsState({final  Set<AchievementId> unlocked = const <AchievementId>{}, this.dailyStreak = 0, this.lastDailyWinDateKey}): _unlocked = unlocked,super._();
  factory _AchievementsState.fromJson(Map<String, dynamic> json) => _$AchievementsStateFromJson(json);

 final  Set<AchievementId> _unlocked;
@override@JsonKey() Set<AchievementId> get unlocked {
  if (_unlocked is EqualUnmodifiableSetView) return _unlocked;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_unlocked);
}

@override@JsonKey() final  int dailyStreak;
@override final  String? lastDailyWinDateKey;

/// Create a copy of AchievementsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementsStateCopyWith<_AchievementsState> get copyWith => __$AchievementsStateCopyWithImpl<_AchievementsState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AchievementsStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchievementsState&&const DeepCollectionEquality().equals(other._unlocked, _unlocked)&&(identical(other.dailyStreak, dailyStreak) || other.dailyStreak == dailyStreak)&&(identical(other.lastDailyWinDateKey, lastDailyWinDateKey) || other.lastDailyWinDateKey == lastDailyWinDateKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_unlocked),dailyStreak,lastDailyWinDateKey);

@override
String toString() {
  return 'AchievementsState(unlocked: $unlocked, dailyStreak: $dailyStreak, lastDailyWinDateKey: $lastDailyWinDateKey)';
}


}

/// @nodoc
abstract mixin class _$AchievementsStateCopyWith<$Res> implements $AchievementsStateCopyWith<$Res> {
  factory _$AchievementsStateCopyWith(_AchievementsState value, $Res Function(_AchievementsState) _then) = __$AchievementsStateCopyWithImpl;
@override @useResult
$Res call({
 Set<AchievementId> unlocked, int dailyStreak, String? lastDailyWinDateKey
});




}
/// @nodoc
class __$AchievementsStateCopyWithImpl<$Res>
    implements _$AchievementsStateCopyWith<$Res> {
  __$AchievementsStateCopyWithImpl(this._self, this._then);

  final _AchievementsState _self;
  final $Res Function(_AchievementsState) _then;

/// Create a copy of AchievementsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unlocked = null,Object? dailyStreak = null,Object? lastDailyWinDateKey = freezed,}) {
  return _then(_AchievementsState(
unlocked: null == unlocked ? _self._unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as Set<AchievementId>,dailyStreak: null == dailyStreak ? _self.dailyStreak : dailyStreak // ignore: cast_nullable_to_non_nullable
as int,lastDailyWinDateKey: freezed == lastDailyWinDateKey ? _self.lastDailyWinDateKey : lastDailyWinDateKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
