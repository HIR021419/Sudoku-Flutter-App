// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'undo_cell.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UndoCell {

@JsonKey(name: 'i') int get index;@JsonKey(name: 'v') int get value;@JsonKey(name: 'n')@IntSetConverter() Set<int> get notes;@JsonKey(name: 'e') bool get hasVisibleError;@JsonKey(name: 'ok') bool get isValidatedCorrect;
/// Create a copy of UndoCell
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UndoCellCopyWith<UndoCell> get copyWith => _$UndoCellCopyWithImpl<UndoCell>(this as UndoCell, _$identity);

  /// Serializes this UndoCell to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UndoCell&&(identical(other.index, index) || other.index == index)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.notes, notes)&&(identical(other.hasVisibleError, hasVisibleError) || other.hasVisibleError == hasVisibleError)&&(identical(other.isValidatedCorrect, isValidatedCorrect) || other.isValidatedCorrect == isValidatedCorrect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,value,const DeepCollectionEquality().hash(notes),hasVisibleError,isValidatedCorrect);

@override
String toString() {
  return 'UndoCell(index: $index, value: $value, notes: $notes, hasVisibleError: $hasVisibleError, isValidatedCorrect: $isValidatedCorrect)';
}


}

/// @nodoc
abstract mixin class $UndoCellCopyWith<$Res>  {
  factory $UndoCellCopyWith(UndoCell value, $Res Function(UndoCell) _then) = _$UndoCellCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'i') int index,@JsonKey(name: 'v') int value,@JsonKey(name: 'n')@IntSetConverter() Set<int> notes,@JsonKey(name: 'e') bool hasVisibleError,@JsonKey(name: 'ok') bool isValidatedCorrect
});




}
/// @nodoc
class _$UndoCellCopyWithImpl<$Res>
    implements $UndoCellCopyWith<$Res> {
  _$UndoCellCopyWithImpl(this._self, this._then);

  final UndoCell _self;
  final $Res Function(UndoCell) _then;

/// Create a copy of UndoCell
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? value = null,Object? notes = null,Object? hasVisibleError = null,Object? isValidatedCorrect = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as Set<int>,hasVisibleError: null == hasVisibleError ? _self.hasVisibleError : hasVisibleError // ignore: cast_nullable_to_non_nullable
as bool,isValidatedCorrect: null == isValidatedCorrect ? _self.isValidatedCorrect : isValidatedCorrect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UndoCell].
extension UndoCellPatterns on UndoCell {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UndoCell value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UndoCell() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UndoCell value)  $default,){
final _that = this;
switch (_that) {
case _UndoCell():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UndoCell value)?  $default,){
final _that = this;
switch (_that) {
case _UndoCell() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  int index, @JsonKey(name: 'v')  int value, @JsonKey(name: 'n')@IntSetConverter()  Set<int> notes, @JsonKey(name: 'e')  bool hasVisibleError, @JsonKey(name: 'ok')  bool isValidatedCorrect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UndoCell() when $default != null:
return $default(_that.index,_that.value,_that.notes,_that.hasVisibleError,_that.isValidatedCorrect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  int index, @JsonKey(name: 'v')  int value, @JsonKey(name: 'n')@IntSetConverter()  Set<int> notes, @JsonKey(name: 'e')  bool hasVisibleError, @JsonKey(name: 'ok')  bool isValidatedCorrect)  $default,) {final _that = this;
switch (_that) {
case _UndoCell():
return $default(_that.index,_that.value,_that.notes,_that.hasVisibleError,_that.isValidatedCorrect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'i')  int index, @JsonKey(name: 'v')  int value, @JsonKey(name: 'n')@IntSetConverter()  Set<int> notes, @JsonKey(name: 'e')  bool hasVisibleError, @JsonKey(name: 'ok')  bool isValidatedCorrect)?  $default,) {final _that = this;
switch (_that) {
case _UndoCell() when $default != null:
return $default(_that.index,_that.value,_that.notes,_that.hasVisibleError,_that.isValidatedCorrect);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UndoCell implements UndoCell {
  const _UndoCell({@JsonKey(name: 'i') required this.index, @JsonKey(name: 'v') required this.value, @JsonKey(name: 'n')@IntSetConverter() required final  Set<int> notes, @JsonKey(name: 'e') required this.hasVisibleError, @JsonKey(name: 'ok') required this.isValidatedCorrect}): _notes = notes;
  factory _UndoCell.fromJson(Map<String, dynamic> json) => _$UndoCellFromJson(json);

@override@JsonKey(name: 'i') final  int index;
@override@JsonKey(name: 'v') final  int value;
 final  Set<int> _notes;
@override@JsonKey(name: 'n')@IntSetConverter() Set<int> get notes {
  if (_notes is EqualUnmodifiableSetView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_notes);
}

@override@JsonKey(name: 'e') final  bool hasVisibleError;
@override@JsonKey(name: 'ok') final  bool isValidatedCorrect;

/// Create a copy of UndoCell
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UndoCellCopyWith<_UndoCell> get copyWith => __$UndoCellCopyWithImpl<_UndoCell>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UndoCellToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UndoCell&&(identical(other.index, index) || other.index == index)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other._notes, _notes)&&(identical(other.hasVisibleError, hasVisibleError) || other.hasVisibleError == hasVisibleError)&&(identical(other.isValidatedCorrect, isValidatedCorrect) || other.isValidatedCorrect == isValidatedCorrect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,value,const DeepCollectionEquality().hash(_notes),hasVisibleError,isValidatedCorrect);

@override
String toString() {
  return 'UndoCell(index: $index, value: $value, notes: $notes, hasVisibleError: $hasVisibleError, isValidatedCorrect: $isValidatedCorrect)';
}


}

/// @nodoc
abstract mixin class _$UndoCellCopyWith<$Res> implements $UndoCellCopyWith<$Res> {
  factory _$UndoCellCopyWith(_UndoCell value, $Res Function(_UndoCell) _then) = __$UndoCellCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'i') int index,@JsonKey(name: 'v') int value,@JsonKey(name: 'n')@IntSetConverter() Set<int> notes,@JsonKey(name: 'e') bool hasVisibleError,@JsonKey(name: 'ok') bool isValidatedCorrect
});




}
/// @nodoc
class __$UndoCellCopyWithImpl<$Res>
    implements _$UndoCellCopyWith<$Res> {
  __$UndoCellCopyWithImpl(this._self, this._then);

  final _UndoCell _self;
  final $Res Function(_UndoCell) _then;

/// Create a copy of UndoCell
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? value = null,Object? notes = null,Object? hasVisibleError = null,Object? isValidatedCorrect = null,}) {
  return _then(_UndoCell(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as Set<int>,hasVisibleError: null == hasVisibleError ? _self.hasVisibleError : hasVisibleError // ignore: cast_nullable_to_non_nullable
as bool,isValidatedCorrect: null == isValidatedCorrect ? _self.isValidatedCorrect : isValidatedCorrect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
