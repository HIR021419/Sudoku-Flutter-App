// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameSession {

 DifficultyEnum get difficulty; List<int> get solution; List<int> get userGrid;@IntSetConverter() Set<int> get givens;@NotesMapConverter() Map<int, Set<int>> get notes;@_UndoStackConverter() List<UndoEntry> get undoStack;@IntSetConverter() Set<int> get revealedErrors;@IntSetConverter() Set<int> get validatedCorrect; int get errorCount; int get hintsUsed;@JsonKey(name: 'elapsedMs')@DurationMsConverter() Duration get elapsedAtRestore;
/// Create a copy of GameSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameSessionCopyWith<GameSession> get copyWith => _$GameSessionCopyWithImpl<GameSession>(this as GameSession, _$identity);

  /// Serializes this GameSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameSession&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&const DeepCollectionEquality().equals(other.solution, solution)&&const DeepCollectionEquality().equals(other.userGrid, userGrid)&&const DeepCollectionEquality().equals(other.givens, givens)&&const DeepCollectionEquality().equals(other.notes, notes)&&const DeepCollectionEquality().equals(other.undoStack, undoStack)&&const DeepCollectionEquality().equals(other.revealedErrors, revealedErrors)&&const DeepCollectionEquality().equals(other.validatedCorrect, validatedCorrect)&&(identical(other.errorCount, errorCount) || other.errorCount == errorCount)&&(identical(other.hintsUsed, hintsUsed) || other.hintsUsed == hintsUsed)&&(identical(other.elapsedAtRestore, elapsedAtRestore) || other.elapsedAtRestore == elapsedAtRestore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,difficulty,const DeepCollectionEquality().hash(solution),const DeepCollectionEquality().hash(userGrid),const DeepCollectionEquality().hash(givens),const DeepCollectionEquality().hash(notes),const DeepCollectionEquality().hash(undoStack),const DeepCollectionEquality().hash(revealedErrors),const DeepCollectionEquality().hash(validatedCorrect),errorCount,hintsUsed,elapsedAtRestore);

@override
String toString() {
  return 'GameSession(difficulty: $difficulty, solution: $solution, userGrid: $userGrid, givens: $givens, notes: $notes, undoStack: $undoStack, revealedErrors: $revealedErrors, validatedCorrect: $validatedCorrect, errorCount: $errorCount, hintsUsed: $hintsUsed, elapsedAtRestore: $elapsedAtRestore)';
}


}

/// @nodoc
abstract mixin class $GameSessionCopyWith<$Res>  {
  factory $GameSessionCopyWith(GameSession value, $Res Function(GameSession) _then) = _$GameSessionCopyWithImpl;
@useResult
$Res call({
 DifficultyEnum difficulty, List<int> solution, List<int> userGrid,@IntSetConverter() Set<int> givens,@NotesMapConverter() Map<int, Set<int>> notes,@_UndoStackConverter() List<UndoEntry> undoStack,@IntSetConverter() Set<int> revealedErrors,@IntSetConverter() Set<int> validatedCorrect, int errorCount, int hintsUsed,@JsonKey(name: 'elapsedMs')@DurationMsConverter() Duration elapsedAtRestore
});




}
/// @nodoc
class _$GameSessionCopyWithImpl<$Res>
    implements $GameSessionCopyWith<$Res> {
  _$GameSessionCopyWithImpl(this._self, this._then);

  final GameSession _self;
  final $Res Function(GameSession) _then;

/// Create a copy of GameSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? difficulty = null,Object? solution = null,Object? userGrid = null,Object? givens = null,Object? notes = null,Object? undoStack = null,Object? revealedErrors = null,Object? validatedCorrect = null,Object? errorCount = null,Object? hintsUsed = null,Object? elapsedAtRestore = null,}) {
  return _then(_self.copyWith(
difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as DifficultyEnum,solution: null == solution ? _self.solution : solution // ignore: cast_nullable_to_non_nullable
as List<int>,userGrid: null == userGrid ? _self.userGrid : userGrid // ignore: cast_nullable_to_non_nullable
as List<int>,givens: null == givens ? _self.givens : givens // ignore: cast_nullable_to_non_nullable
as Set<int>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as Map<int, Set<int>>,undoStack: null == undoStack ? _self.undoStack : undoStack // ignore: cast_nullable_to_non_nullable
as List<UndoEntry>,revealedErrors: null == revealedErrors ? _self.revealedErrors : revealedErrors // ignore: cast_nullable_to_non_nullable
as Set<int>,validatedCorrect: null == validatedCorrect ? _self.validatedCorrect : validatedCorrect // ignore: cast_nullable_to_non_nullable
as Set<int>,errorCount: null == errorCount ? _self.errorCount : errorCount // ignore: cast_nullable_to_non_nullable
as int,hintsUsed: null == hintsUsed ? _self.hintsUsed : hintsUsed // ignore: cast_nullable_to_non_nullable
as int,elapsedAtRestore: null == elapsedAtRestore ? _self.elapsedAtRestore : elapsedAtRestore // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [GameSession].
extension GameSessionPatterns on GameSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameSession value)  $default,){
final _that = this;
switch (_that) {
case _GameSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameSession value)?  $default,){
final _that = this;
switch (_that) {
case _GameSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DifficultyEnum difficulty,  List<int> solution,  List<int> userGrid, @IntSetConverter()  Set<int> givens, @NotesMapConverter()  Map<int, Set<int>> notes, @_UndoStackConverter()  List<UndoEntry> undoStack, @IntSetConverter()  Set<int> revealedErrors, @IntSetConverter()  Set<int> validatedCorrect,  int errorCount,  int hintsUsed, @JsonKey(name: 'elapsedMs')@DurationMsConverter()  Duration elapsedAtRestore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameSession() when $default != null:
return $default(_that.difficulty,_that.solution,_that.userGrid,_that.givens,_that.notes,_that.undoStack,_that.revealedErrors,_that.validatedCorrect,_that.errorCount,_that.hintsUsed,_that.elapsedAtRestore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DifficultyEnum difficulty,  List<int> solution,  List<int> userGrid, @IntSetConverter()  Set<int> givens, @NotesMapConverter()  Map<int, Set<int>> notes, @_UndoStackConverter()  List<UndoEntry> undoStack, @IntSetConverter()  Set<int> revealedErrors, @IntSetConverter()  Set<int> validatedCorrect,  int errorCount,  int hintsUsed, @JsonKey(name: 'elapsedMs')@DurationMsConverter()  Duration elapsedAtRestore)  $default,) {final _that = this;
switch (_that) {
case _GameSession():
return $default(_that.difficulty,_that.solution,_that.userGrid,_that.givens,_that.notes,_that.undoStack,_that.revealedErrors,_that.validatedCorrect,_that.errorCount,_that.hintsUsed,_that.elapsedAtRestore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DifficultyEnum difficulty,  List<int> solution,  List<int> userGrid, @IntSetConverter()  Set<int> givens, @NotesMapConverter()  Map<int, Set<int>> notes, @_UndoStackConverter()  List<UndoEntry> undoStack, @IntSetConverter()  Set<int> revealedErrors, @IntSetConverter()  Set<int> validatedCorrect,  int errorCount,  int hintsUsed, @JsonKey(name: 'elapsedMs')@DurationMsConverter()  Duration elapsedAtRestore)?  $default,) {final _that = this;
switch (_that) {
case _GameSession() when $default != null:
return $default(_that.difficulty,_that.solution,_that.userGrid,_that.givens,_that.notes,_that.undoStack,_that.revealedErrors,_that.validatedCorrect,_that.errorCount,_that.hintsUsed,_that.elapsedAtRestore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameSession extends GameSession {
  const _GameSession({required this.difficulty, required final  List<int> solution, required final  List<int> userGrid, @IntSetConverter() required final  Set<int> givens, @NotesMapConverter() final  Map<int, Set<int>> notes = const <int, Set<int>>{}, @_UndoStackConverter() final  List<UndoEntry> undoStack = const <UndoEntry>[], @IntSetConverter() final  Set<int> revealedErrors = const <int>{}, @IntSetConverter() final  Set<int> validatedCorrect = const <int>{}, this.errorCount = 0, this.hintsUsed = 0, @JsonKey(name: 'elapsedMs')@DurationMsConverter() this.elapsedAtRestore = Duration.zero}): _solution = solution,_userGrid = userGrid,_givens = givens,_notes = notes,_undoStack = undoStack,_revealedErrors = revealedErrors,_validatedCorrect = validatedCorrect,super._();
  factory _GameSession.fromJson(Map<String, dynamic> json) => _$GameSessionFromJson(json);

@override final  DifficultyEnum difficulty;
 final  List<int> _solution;
@override List<int> get solution {
  if (_solution is EqualUnmodifiableListView) return _solution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_solution);
}

 final  List<int> _userGrid;
@override List<int> get userGrid {
  if (_userGrid is EqualUnmodifiableListView) return _userGrid;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userGrid);
}

 final  Set<int> _givens;
@override@IntSetConverter() Set<int> get givens {
  if (_givens is EqualUnmodifiableSetView) return _givens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_givens);
}

 final  Map<int, Set<int>> _notes;
@override@JsonKey()@NotesMapConverter() Map<int, Set<int>> get notes {
  if (_notes is EqualUnmodifiableMapView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_notes);
}

 final  List<UndoEntry> _undoStack;
@override@JsonKey()@_UndoStackConverter() List<UndoEntry> get undoStack {
  if (_undoStack is EqualUnmodifiableListView) return _undoStack;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_undoStack);
}

 final  Set<int> _revealedErrors;
@override@JsonKey()@IntSetConverter() Set<int> get revealedErrors {
  if (_revealedErrors is EqualUnmodifiableSetView) return _revealedErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_revealedErrors);
}

 final  Set<int> _validatedCorrect;
@override@JsonKey()@IntSetConverter() Set<int> get validatedCorrect {
  if (_validatedCorrect is EqualUnmodifiableSetView) return _validatedCorrect;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_validatedCorrect);
}

@override@JsonKey() final  int errorCount;
@override@JsonKey() final  int hintsUsed;
@override@JsonKey(name: 'elapsedMs')@DurationMsConverter() final  Duration elapsedAtRestore;

/// Create a copy of GameSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameSessionCopyWith<_GameSession> get copyWith => __$GameSessionCopyWithImpl<_GameSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameSession&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&const DeepCollectionEquality().equals(other._solution, _solution)&&const DeepCollectionEquality().equals(other._userGrid, _userGrid)&&const DeepCollectionEquality().equals(other._givens, _givens)&&const DeepCollectionEquality().equals(other._notes, _notes)&&const DeepCollectionEquality().equals(other._undoStack, _undoStack)&&const DeepCollectionEquality().equals(other._revealedErrors, _revealedErrors)&&const DeepCollectionEquality().equals(other._validatedCorrect, _validatedCorrect)&&(identical(other.errorCount, errorCount) || other.errorCount == errorCount)&&(identical(other.hintsUsed, hintsUsed) || other.hintsUsed == hintsUsed)&&(identical(other.elapsedAtRestore, elapsedAtRestore) || other.elapsedAtRestore == elapsedAtRestore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,difficulty,const DeepCollectionEquality().hash(_solution),const DeepCollectionEquality().hash(_userGrid),const DeepCollectionEquality().hash(_givens),const DeepCollectionEquality().hash(_notes),const DeepCollectionEquality().hash(_undoStack),const DeepCollectionEquality().hash(_revealedErrors),const DeepCollectionEquality().hash(_validatedCorrect),errorCount,hintsUsed,elapsedAtRestore);

@override
String toString() {
  return 'GameSession(difficulty: $difficulty, solution: $solution, userGrid: $userGrid, givens: $givens, notes: $notes, undoStack: $undoStack, revealedErrors: $revealedErrors, validatedCorrect: $validatedCorrect, errorCount: $errorCount, hintsUsed: $hintsUsed, elapsedAtRestore: $elapsedAtRestore)';
}


}

/// @nodoc
abstract mixin class _$GameSessionCopyWith<$Res> implements $GameSessionCopyWith<$Res> {
  factory _$GameSessionCopyWith(_GameSession value, $Res Function(_GameSession) _then) = __$GameSessionCopyWithImpl;
@override @useResult
$Res call({
 DifficultyEnum difficulty, List<int> solution, List<int> userGrid,@IntSetConverter() Set<int> givens,@NotesMapConverter() Map<int, Set<int>> notes,@_UndoStackConverter() List<UndoEntry> undoStack,@IntSetConverter() Set<int> revealedErrors,@IntSetConverter() Set<int> validatedCorrect, int errorCount, int hintsUsed,@JsonKey(name: 'elapsedMs')@DurationMsConverter() Duration elapsedAtRestore
});




}
/// @nodoc
class __$GameSessionCopyWithImpl<$Res>
    implements _$GameSessionCopyWith<$Res> {
  __$GameSessionCopyWithImpl(this._self, this._then);

  final _GameSession _self;
  final $Res Function(_GameSession) _then;

/// Create a copy of GameSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? difficulty = null,Object? solution = null,Object? userGrid = null,Object? givens = null,Object? notes = null,Object? undoStack = null,Object? revealedErrors = null,Object? validatedCorrect = null,Object? errorCount = null,Object? hintsUsed = null,Object? elapsedAtRestore = null,}) {
  return _then(_GameSession(
difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as DifficultyEnum,solution: null == solution ? _self._solution : solution // ignore: cast_nullable_to_non_nullable
as List<int>,userGrid: null == userGrid ? _self._userGrid : userGrid // ignore: cast_nullable_to_non_nullable
as List<int>,givens: null == givens ? _self._givens : givens // ignore: cast_nullable_to_non_nullable
as Set<int>,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as Map<int, Set<int>>,undoStack: null == undoStack ? _self._undoStack : undoStack // ignore: cast_nullable_to_non_nullable
as List<UndoEntry>,revealedErrors: null == revealedErrors ? _self._revealedErrors : revealedErrors // ignore: cast_nullable_to_non_nullable
as Set<int>,validatedCorrect: null == validatedCorrect ? _self._validatedCorrect : validatedCorrect // ignore: cast_nullable_to_non_nullable
as Set<int>,errorCount: null == errorCount ? _self.errorCount : errorCount // ignore: cast_nullable_to_non_nullable
as int,hintsUsed: null == hintsUsed ? _self.hintsUsed : hintsUsed // ignore: cast_nullable_to_non_nullable
as int,elapsedAtRestore: null == elapsedAtRestore ? _self.elapsedAtRestore : elapsedAtRestore // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
