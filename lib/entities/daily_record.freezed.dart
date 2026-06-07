// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyRecord {

/// Clé `yyyy-MM-dd` (UTC) — cf. `dailyDateKey`.
 String get dateKey; DailyOutcome get outcome;/// Temps effectif (brut + pénalités) — non nul uniquement si victoire.
@JsonKey(name: 'effectiveMs')@NullableDurationMsConverter() Duration? get effectiveTime; int get errorCount; int get hintsUsed;
/// Create a copy of DailyRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyRecordCopyWith<DailyRecord> get copyWith => _$DailyRecordCopyWithImpl<DailyRecord>(this as DailyRecord, _$identity);

  /// Serializes this DailyRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyRecord&&(identical(other.dateKey, dateKey) || other.dateKey == dateKey)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.effectiveTime, effectiveTime) || other.effectiveTime == effectiveTime)&&(identical(other.errorCount, errorCount) || other.errorCount == errorCount)&&(identical(other.hintsUsed, hintsUsed) || other.hintsUsed == hintsUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateKey,outcome,effectiveTime,errorCount,hintsUsed);

@override
String toString() {
  return 'DailyRecord(dateKey: $dateKey, outcome: $outcome, effectiveTime: $effectiveTime, errorCount: $errorCount, hintsUsed: $hintsUsed)';
}


}

/// @nodoc
abstract mixin class $DailyRecordCopyWith<$Res>  {
  factory $DailyRecordCopyWith(DailyRecord value, $Res Function(DailyRecord) _then) = _$DailyRecordCopyWithImpl;
@useResult
$Res call({
 String dateKey, DailyOutcome outcome,@JsonKey(name: 'effectiveMs')@NullableDurationMsConverter() Duration? effectiveTime, int errorCount, int hintsUsed
});




}
/// @nodoc
class _$DailyRecordCopyWithImpl<$Res>
    implements $DailyRecordCopyWith<$Res> {
  _$DailyRecordCopyWithImpl(this._self, this._then);

  final DailyRecord _self;
  final $Res Function(DailyRecord) _then;

/// Create a copy of DailyRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateKey = null,Object? outcome = null,Object? effectiveTime = freezed,Object? errorCount = null,Object? hintsUsed = null,}) {
  return _then(_self.copyWith(
dateKey: null == dateKey ? _self.dateKey : dateKey // ignore: cast_nullable_to_non_nullable
as String,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as DailyOutcome,effectiveTime: freezed == effectiveTime ? _self.effectiveTime : effectiveTime // ignore: cast_nullable_to_non_nullable
as Duration?,errorCount: null == errorCount ? _self.errorCount : errorCount // ignore: cast_nullable_to_non_nullable
as int,hintsUsed: null == hintsUsed ? _self.hintsUsed : hintsUsed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyRecord].
extension DailyRecordPatterns on DailyRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyRecord value)  $default,){
final _that = this;
switch (_that) {
case _DailyRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyRecord value)?  $default,){
final _that = this;
switch (_that) {
case _DailyRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dateKey,  DailyOutcome outcome, @JsonKey(name: 'effectiveMs')@NullableDurationMsConverter()  Duration? effectiveTime,  int errorCount,  int hintsUsed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyRecord() when $default != null:
return $default(_that.dateKey,_that.outcome,_that.effectiveTime,_that.errorCount,_that.hintsUsed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dateKey,  DailyOutcome outcome, @JsonKey(name: 'effectiveMs')@NullableDurationMsConverter()  Duration? effectiveTime,  int errorCount,  int hintsUsed)  $default,) {final _that = this;
switch (_that) {
case _DailyRecord():
return $default(_that.dateKey,_that.outcome,_that.effectiveTime,_that.errorCount,_that.hintsUsed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dateKey,  DailyOutcome outcome, @JsonKey(name: 'effectiveMs')@NullableDurationMsConverter()  Duration? effectiveTime,  int errorCount,  int hintsUsed)?  $default,) {final _that = this;
switch (_that) {
case _DailyRecord() when $default != null:
return $default(_that.dateKey,_that.outcome,_that.effectiveTime,_that.errorCount,_that.hintsUsed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyRecord extends DailyRecord {
  const _DailyRecord({required this.dateKey, required this.outcome, @JsonKey(name: 'effectiveMs')@NullableDurationMsConverter() this.effectiveTime, this.errorCount = 0, this.hintsUsed = 0}): super._();
  factory _DailyRecord.fromJson(Map<String, dynamic> json) => _$DailyRecordFromJson(json);

/// Clé `yyyy-MM-dd` (UTC) — cf. `dailyDateKey`.
@override final  String dateKey;
@override final  DailyOutcome outcome;
/// Temps effectif (brut + pénalités) — non nul uniquement si victoire.
@override@JsonKey(name: 'effectiveMs')@NullableDurationMsConverter() final  Duration? effectiveTime;
@override@JsonKey() final  int errorCount;
@override@JsonKey() final  int hintsUsed;

/// Create a copy of DailyRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyRecordCopyWith<_DailyRecord> get copyWith => __$DailyRecordCopyWithImpl<_DailyRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyRecord&&(identical(other.dateKey, dateKey) || other.dateKey == dateKey)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.effectiveTime, effectiveTime) || other.effectiveTime == effectiveTime)&&(identical(other.errorCount, errorCount) || other.errorCount == errorCount)&&(identical(other.hintsUsed, hintsUsed) || other.hintsUsed == hintsUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateKey,outcome,effectiveTime,errorCount,hintsUsed);

@override
String toString() {
  return 'DailyRecord(dateKey: $dateKey, outcome: $outcome, effectiveTime: $effectiveTime, errorCount: $errorCount, hintsUsed: $hintsUsed)';
}


}

/// @nodoc
abstract mixin class _$DailyRecordCopyWith<$Res> implements $DailyRecordCopyWith<$Res> {
  factory _$DailyRecordCopyWith(_DailyRecord value, $Res Function(_DailyRecord) _then) = __$DailyRecordCopyWithImpl;
@override @useResult
$Res call({
 String dateKey, DailyOutcome outcome,@JsonKey(name: 'effectiveMs')@NullableDurationMsConverter() Duration? effectiveTime, int errorCount, int hintsUsed
});




}
/// @nodoc
class __$DailyRecordCopyWithImpl<$Res>
    implements _$DailyRecordCopyWith<$Res> {
  __$DailyRecordCopyWithImpl(this._self, this._then);

  final _DailyRecord _self;
  final $Res Function(_DailyRecord) _then;

/// Create a copy of DailyRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateKey = null,Object? outcome = null,Object? effectiveTime = freezed,Object? errorCount = null,Object? hintsUsed = null,}) {
  return _then(_DailyRecord(
dateKey: null == dateKey ? _self.dateKey : dateKey // ignore: cast_nullable_to_non_nullable
as String,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as DailyOutcome,effectiveTime: freezed == effectiveTime ? _self.effectiveTime : effectiveTime // ignore: cast_nullable_to_non_nullable
as Duration?,errorCount: null == errorCount ? _self.errorCount : errorCount // ignore: cast_nullable_to_non_nullable
as int,hintsUsed: null == hintsUsed ? _self.hintsUsed : hintsUsed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
