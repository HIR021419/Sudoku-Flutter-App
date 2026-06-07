// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyState implements DiagnosticableTreeMixin {

 String get todayKey; DailyRecord? get record;
/// Create a copy of DailyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyStateCopyWith<DailyState> get copyWith => _$DailyStateCopyWithImpl<DailyState>(this as DailyState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DailyState'))
    ..add(DiagnosticsProperty('todayKey', todayKey))..add(DiagnosticsProperty('record', record));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyState&&(identical(other.todayKey, todayKey) || other.todayKey == todayKey)&&(identical(other.record, record) || other.record == record));
}


@override
int get hashCode => Object.hash(runtimeType,todayKey,record);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DailyState(todayKey: $todayKey, record: $record)';
}


}

/// @nodoc
abstract mixin class $DailyStateCopyWith<$Res>  {
  factory $DailyStateCopyWith(DailyState value, $Res Function(DailyState) _then) = _$DailyStateCopyWithImpl;
@useResult
$Res call({
 String todayKey, DailyRecord? record
});


$DailyRecordCopyWith<$Res>? get record;

}
/// @nodoc
class _$DailyStateCopyWithImpl<$Res>
    implements $DailyStateCopyWith<$Res> {
  _$DailyStateCopyWithImpl(this._self, this._then);

  final DailyState _self;
  final $Res Function(DailyState) _then;

/// Create a copy of DailyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todayKey = null,Object? record = freezed,}) {
  return _then(_self.copyWith(
todayKey: null == todayKey ? _self.todayKey : todayKey // ignore: cast_nullable_to_non_nullable
as String,record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as DailyRecord?,
  ));
}
/// Create a copy of DailyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DailyRecordCopyWith<$Res>? get record {
    if (_self.record == null) {
    return null;
  }

  return $DailyRecordCopyWith<$Res>(_self.record!, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// Adds pattern-matching-related methods to [DailyState].
extension DailyStatePatterns on DailyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyState value)  $default,){
final _that = this;
switch (_that) {
case _DailyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyState value)?  $default,){
final _that = this;
switch (_that) {
case _DailyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String todayKey,  DailyRecord? record)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyState() when $default != null:
return $default(_that.todayKey,_that.record);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String todayKey,  DailyRecord? record)  $default,) {final _that = this;
switch (_that) {
case _DailyState():
return $default(_that.todayKey,_that.record);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String todayKey,  DailyRecord? record)?  $default,) {final _that = this;
switch (_that) {
case _DailyState() when $default != null:
return $default(_that.todayKey,_that.record);case _:
  return null;

}
}

}

/// @nodoc


class _DailyState extends DailyState with DiagnosticableTreeMixin {
  const _DailyState({required this.todayKey, this.record}): super._();
  

@override final  String todayKey;
@override final  DailyRecord? record;

/// Create a copy of DailyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyStateCopyWith<_DailyState> get copyWith => __$DailyStateCopyWithImpl<_DailyState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DailyState'))
    ..add(DiagnosticsProperty('todayKey', todayKey))..add(DiagnosticsProperty('record', record));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyState&&(identical(other.todayKey, todayKey) || other.todayKey == todayKey)&&(identical(other.record, record) || other.record == record));
}


@override
int get hashCode => Object.hash(runtimeType,todayKey,record);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DailyState(todayKey: $todayKey, record: $record)';
}


}

/// @nodoc
abstract mixin class _$DailyStateCopyWith<$Res> implements $DailyStateCopyWith<$Res> {
  factory _$DailyStateCopyWith(_DailyState value, $Res Function(_DailyState) _then) = __$DailyStateCopyWithImpl;
@override @useResult
$Res call({
 String todayKey, DailyRecord? record
});


@override $DailyRecordCopyWith<$Res>? get record;

}
/// @nodoc
class __$DailyStateCopyWithImpl<$Res>
    implements _$DailyStateCopyWith<$Res> {
  __$DailyStateCopyWithImpl(this._self, this._then);

  final _DailyState _self;
  final $Res Function(_DailyState) _then;

/// Create a copy of DailyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todayKey = null,Object? record = freezed,}) {
  return _then(_DailyState(
todayKey: null == todayKey ? _self.todayKey : todayKey // ignore: cast_nullable_to_non_nullable
as String,record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as DailyRecord?,
  ));
}

/// Create a copy of DailyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DailyRecordCopyWith<$Res>? get record {
    if (_self.record == null) {
    return null;
  }

  return $DailyRecordCopyWith<$Res>(_self.record!, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}

// dart format on
