// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameUiState {

@JsonKey(includeFromJson: false, includeToJson: false) int? get selectedIndex; bool get notesMode; bool get fillMode; int? get activeNumber;
/// Create a copy of GameUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameUiStateCopyWith<GameUiState> get copyWith => _$GameUiStateCopyWithImpl<GameUiState>(this as GameUiState, _$identity);

  /// Serializes this GameUiState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameUiState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.notesMode, notesMode) || other.notesMode == notesMode)&&(identical(other.fillMode, fillMode) || other.fillMode == fillMode)&&(identical(other.activeNumber, activeNumber) || other.activeNumber == activeNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selectedIndex,notesMode,fillMode,activeNumber);

@override
String toString() {
  return 'GameUiState(selectedIndex: $selectedIndex, notesMode: $notesMode, fillMode: $fillMode, activeNumber: $activeNumber)';
}


}

/// @nodoc
abstract mixin class $GameUiStateCopyWith<$Res>  {
  factory $GameUiStateCopyWith(GameUiState value, $Res Function(GameUiState) _then) = _$GameUiStateCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) int? selectedIndex, bool notesMode, bool fillMode, int? activeNumber
});




}
/// @nodoc
class _$GameUiStateCopyWithImpl<$Res>
    implements $GameUiStateCopyWith<$Res> {
  _$GameUiStateCopyWithImpl(this._self, this._then);

  final GameUiState _self;
  final $Res Function(GameUiState) _then;

/// Create a copy of GameUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedIndex = freezed,Object? notesMode = null,Object? fillMode = null,Object? activeNumber = freezed,}) {
  return _then(_self.copyWith(
selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,notesMode: null == notesMode ? _self.notesMode : notesMode // ignore: cast_nullable_to_non_nullable
as bool,fillMode: null == fillMode ? _self.fillMode : fillMode // ignore: cast_nullable_to_non_nullable
as bool,activeNumber: freezed == activeNumber ? _self.activeNumber : activeNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [GameUiState].
extension GameUiStatePatterns on GameUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameUiState value)  $default,){
final _that = this;
switch (_that) {
case _GameUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameUiState value)?  $default,){
final _that = this;
switch (_that) {
case _GameUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  int? selectedIndex,  bool notesMode,  bool fillMode,  int? activeNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameUiState() when $default != null:
return $default(_that.selectedIndex,_that.notesMode,_that.fillMode,_that.activeNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  int? selectedIndex,  bool notesMode,  bool fillMode,  int? activeNumber)  $default,) {final _that = this;
switch (_that) {
case _GameUiState():
return $default(_that.selectedIndex,_that.notesMode,_that.fillMode,_that.activeNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  int? selectedIndex,  bool notesMode,  bool fillMode,  int? activeNumber)?  $default,) {final _that = this;
switch (_that) {
case _GameUiState() when $default != null:
return $default(_that.selectedIndex,_that.notesMode,_that.fillMode,_that.activeNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameUiState implements GameUiState {
  const _GameUiState({@JsonKey(includeFromJson: false, includeToJson: false) this.selectedIndex, this.notesMode = false, this.fillMode = false, this.activeNumber});
  factory _GameUiState.fromJson(Map<String, dynamic> json) => _$GameUiStateFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false) final  int? selectedIndex;
@override@JsonKey() final  bool notesMode;
@override@JsonKey() final  bool fillMode;
@override final  int? activeNumber;

/// Create a copy of GameUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameUiStateCopyWith<_GameUiState> get copyWith => __$GameUiStateCopyWithImpl<_GameUiState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameUiStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameUiState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.notesMode, notesMode) || other.notesMode == notesMode)&&(identical(other.fillMode, fillMode) || other.fillMode == fillMode)&&(identical(other.activeNumber, activeNumber) || other.activeNumber == activeNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selectedIndex,notesMode,fillMode,activeNumber);

@override
String toString() {
  return 'GameUiState(selectedIndex: $selectedIndex, notesMode: $notesMode, fillMode: $fillMode, activeNumber: $activeNumber)';
}


}

/// @nodoc
abstract mixin class _$GameUiStateCopyWith<$Res> implements $GameUiStateCopyWith<$Res> {
  factory _$GameUiStateCopyWith(_GameUiState value, $Res Function(_GameUiState) _then) = __$GameUiStateCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) int? selectedIndex, bool notesMode, bool fillMode, int? activeNumber
});




}
/// @nodoc
class __$GameUiStateCopyWithImpl<$Res>
    implements _$GameUiStateCopyWith<$Res> {
  __$GameUiStateCopyWithImpl(this._self, this._then);

  final _GameUiState _self;
  final $Res Function(_GameUiState) _then;

/// Create a copy of GameUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedIndex = freezed,Object? notesMode = null,Object? fillMode = null,Object? activeNumber = freezed,}) {
  return _then(_GameUiState(
selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,notesMode: null == notesMode ? _self.notesMode : notesMode // ignore: cast_nullable_to_non_nullable
as bool,fillMode: null == fillMode ? _self.fillMode : fillMode // ignore: cast_nullable_to_non_nullable
as bool,activeNumber: freezed == activeNumber ? _self.activeNumber : activeNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
