// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DifficultyStats {

 int get gamesSolved;@JsonKey(name: 'bestTimeMs')@_NullableDurationMsConverter() Duration? get bestTime;
/// Create a copy of DifficultyStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DifficultyStatsCopyWith<DifficultyStats> get copyWith => _$DifficultyStatsCopyWithImpl<DifficultyStats>(this as DifficultyStats, _$identity);

  /// Serializes this DifficultyStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DifficultyStats&&(identical(other.gamesSolved, gamesSolved) || other.gamesSolved == gamesSolved)&&(identical(other.bestTime, bestTime) || other.bestTime == bestTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gamesSolved,bestTime);

@override
String toString() {
  return 'DifficultyStats(gamesSolved: $gamesSolved, bestTime: $bestTime)';
}


}

/// @nodoc
abstract mixin class $DifficultyStatsCopyWith<$Res>  {
  factory $DifficultyStatsCopyWith(DifficultyStats value, $Res Function(DifficultyStats) _then) = _$DifficultyStatsCopyWithImpl;
@useResult
$Res call({
 int gamesSolved,@JsonKey(name: 'bestTimeMs')@_NullableDurationMsConverter() Duration? bestTime
});




}
/// @nodoc
class _$DifficultyStatsCopyWithImpl<$Res>
    implements $DifficultyStatsCopyWith<$Res> {
  _$DifficultyStatsCopyWithImpl(this._self, this._then);

  final DifficultyStats _self;
  final $Res Function(DifficultyStats) _then;

/// Create a copy of DifficultyStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gamesSolved = null,Object? bestTime = freezed,}) {
  return _then(_self.copyWith(
gamesSolved: null == gamesSolved ? _self.gamesSolved : gamesSolved // ignore: cast_nullable_to_non_nullable
as int,bestTime: freezed == bestTime ? _self.bestTime : bestTime // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

}


/// Adds pattern-matching-related methods to [DifficultyStats].
extension DifficultyStatsPatterns on DifficultyStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DifficultyStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DifficultyStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DifficultyStats value)  $default,){
final _that = this;
switch (_that) {
case _DifficultyStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DifficultyStats value)?  $default,){
final _that = this;
switch (_that) {
case _DifficultyStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gamesSolved, @JsonKey(name: 'bestTimeMs')@_NullableDurationMsConverter()  Duration? bestTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DifficultyStats() when $default != null:
return $default(_that.gamesSolved,_that.bestTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gamesSolved, @JsonKey(name: 'bestTimeMs')@_NullableDurationMsConverter()  Duration? bestTime)  $default,) {final _that = this;
switch (_that) {
case _DifficultyStats():
return $default(_that.gamesSolved,_that.bestTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gamesSolved, @JsonKey(name: 'bestTimeMs')@_NullableDurationMsConverter()  Duration? bestTime)?  $default,) {final _that = this;
switch (_that) {
case _DifficultyStats() when $default != null:
return $default(_that.gamesSolved,_that.bestTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DifficultyStats extends DifficultyStats {
  const _DifficultyStats({this.gamesSolved = 0, @JsonKey(name: 'bestTimeMs')@_NullableDurationMsConverter() this.bestTime}): super._();
  factory _DifficultyStats.fromJson(Map<String, dynamic> json) => _$DifficultyStatsFromJson(json);

@override@JsonKey() final  int gamesSolved;
@override@JsonKey(name: 'bestTimeMs')@_NullableDurationMsConverter() final  Duration? bestTime;

/// Create a copy of DifficultyStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DifficultyStatsCopyWith<_DifficultyStats> get copyWith => __$DifficultyStatsCopyWithImpl<_DifficultyStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DifficultyStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DifficultyStats&&(identical(other.gamesSolved, gamesSolved) || other.gamesSolved == gamesSolved)&&(identical(other.bestTime, bestTime) || other.bestTime == bestTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gamesSolved,bestTime);

@override
String toString() {
  return 'DifficultyStats(gamesSolved: $gamesSolved, bestTime: $bestTime)';
}


}

/// @nodoc
abstract mixin class _$DifficultyStatsCopyWith<$Res> implements $DifficultyStatsCopyWith<$Res> {
  factory _$DifficultyStatsCopyWith(_DifficultyStats value, $Res Function(_DifficultyStats) _then) = __$DifficultyStatsCopyWithImpl;
@override @useResult
$Res call({
 int gamesSolved,@JsonKey(name: 'bestTimeMs')@_NullableDurationMsConverter() Duration? bestTime
});




}
/// @nodoc
class __$DifficultyStatsCopyWithImpl<$Res>
    implements _$DifficultyStatsCopyWith<$Res> {
  __$DifficultyStatsCopyWithImpl(this._self, this._then);

  final _DifficultyStats _self;
  final $Res Function(_DifficultyStats) _then;

/// Create a copy of DifficultyStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gamesSolved = null,Object? bestTime = freezed,}) {
  return _then(_DifficultyStats(
gamesSolved: null == gamesSolved ? _self.gamesSolved : gamesSolved // ignore: cast_nullable_to_non_nullable
as int,bestTime: freezed == bestTime ? _self.bestTime : bestTime // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}


/// @nodoc
mixin _$Stats {

 Map<DifficultyEnum, DifficultyStats> get byDifficulty;
/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatsCopyWith<Stats> get copyWith => _$StatsCopyWithImpl<Stats>(this as Stats, _$identity);

  /// Serializes this Stats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Stats&&const DeepCollectionEquality().equals(other.byDifficulty, byDifficulty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(byDifficulty));

@override
String toString() {
  return 'Stats(byDifficulty: $byDifficulty)';
}


}

/// @nodoc
abstract mixin class $StatsCopyWith<$Res>  {
  factory $StatsCopyWith(Stats value, $Res Function(Stats) _then) = _$StatsCopyWithImpl;
@useResult
$Res call({
 Map<DifficultyEnum, DifficultyStats> byDifficulty
});




}
/// @nodoc
class _$StatsCopyWithImpl<$Res>
    implements $StatsCopyWith<$Res> {
  _$StatsCopyWithImpl(this._self, this._then);

  final Stats _self;
  final $Res Function(Stats) _then;

/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? byDifficulty = null,}) {
  return _then(_self.copyWith(
byDifficulty: null == byDifficulty ? _self.byDifficulty : byDifficulty // ignore: cast_nullable_to_non_nullable
as Map<DifficultyEnum, DifficultyStats>,
  ));
}

}


/// Adds pattern-matching-related methods to [Stats].
extension StatsPatterns on Stats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Stats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Stats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Stats value)  $default,){
final _that = this;
switch (_that) {
case _Stats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Stats value)?  $default,){
final _that = this;
switch (_that) {
case _Stats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<DifficultyEnum, DifficultyStats> byDifficulty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Stats() when $default != null:
return $default(_that.byDifficulty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<DifficultyEnum, DifficultyStats> byDifficulty)  $default,) {final _that = this;
switch (_that) {
case _Stats():
return $default(_that.byDifficulty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<DifficultyEnum, DifficultyStats> byDifficulty)?  $default,) {final _that = this;
switch (_that) {
case _Stats() when $default != null:
return $default(_that.byDifficulty);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Stats extends Stats {
  const _Stats({required final  Map<DifficultyEnum, DifficultyStats> byDifficulty}): _byDifficulty = byDifficulty,super._();
  factory _Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

 final  Map<DifficultyEnum, DifficultyStats> _byDifficulty;
@override Map<DifficultyEnum, DifficultyStats> get byDifficulty {
  if (_byDifficulty is EqualUnmodifiableMapView) return _byDifficulty;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byDifficulty);
}


/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatsCopyWith<_Stats> get copyWith => __$StatsCopyWithImpl<_Stats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Stats&&const DeepCollectionEquality().equals(other._byDifficulty, _byDifficulty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_byDifficulty));

@override
String toString() {
  return 'Stats(byDifficulty: $byDifficulty)';
}


}

/// @nodoc
abstract mixin class _$StatsCopyWith<$Res> implements $StatsCopyWith<$Res> {
  factory _$StatsCopyWith(_Stats value, $Res Function(_Stats) _then) = __$StatsCopyWithImpl;
@override @useResult
$Res call({
 Map<DifficultyEnum, DifficultyStats> byDifficulty
});




}
/// @nodoc
class __$StatsCopyWithImpl<$Res>
    implements _$StatsCopyWith<$Res> {
  __$StatsCopyWithImpl(this._self, this._then);

  final _Stats _self;
  final $Res Function(_Stats) _then;

/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? byDifficulty = null,}) {
  return _then(_Stats(
byDifficulty: null == byDifficulty ? _self._byDifficulty : byDifficulty // ignore: cast_nullable_to_non_nullable
as Map<DifficultyEnum, DifficultyStats>,
  ));
}


}

// dart format on
