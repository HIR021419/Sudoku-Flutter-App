// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Settings {

 bool get soundEnabled; bool get hapticEnabled; ThemePreferenceEnum get theme; ValidationModeEnum get validationMode; bool get hintButtonVisible;
/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsCopyWith<Settings> get copyWith => _$SettingsCopyWithImpl<Settings>(this as Settings, _$identity);

  /// Serializes this Settings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Settings&&(identical(other.soundEnabled, soundEnabled) || other.soundEnabled == soundEnabled)&&(identical(other.hapticEnabled, hapticEnabled) || other.hapticEnabled == hapticEnabled)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.validationMode, validationMode) || other.validationMode == validationMode)&&(identical(other.hintButtonVisible, hintButtonVisible) || other.hintButtonVisible == hintButtonVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,soundEnabled,hapticEnabled,theme,validationMode,hintButtonVisible);

@override
String toString() {
  return 'Settings(soundEnabled: $soundEnabled, hapticEnabled: $hapticEnabled, theme: $theme, validationMode: $validationMode, hintButtonVisible: $hintButtonVisible)';
}


}

/// @nodoc
abstract mixin class $SettingsCopyWith<$Res>  {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) _then) = _$SettingsCopyWithImpl;
@useResult
$Res call({
 bool soundEnabled, bool hapticEnabled, ThemePreferenceEnum theme, ValidationModeEnum validationMode, bool hintButtonVisible
});




}
/// @nodoc
class _$SettingsCopyWithImpl<$Res>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._self, this._then);

  final Settings _self;
  final $Res Function(Settings) _then;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? soundEnabled = null,Object? hapticEnabled = null,Object? theme = null,Object? validationMode = null,Object? hintButtonVisible = null,}) {
  return _then(_self.copyWith(
soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,hapticEnabled: null == hapticEnabled ? _self.hapticEnabled : hapticEnabled // ignore: cast_nullable_to_non_nullable
as bool,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemePreferenceEnum,validationMode: null == validationMode ? _self.validationMode : validationMode // ignore: cast_nullable_to_non_nullable
as ValidationModeEnum,hintButtonVisible: null == hintButtonVisible ? _self.hintButtonVisible : hintButtonVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Settings].
extension SettingsPatterns on Settings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Settings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Settings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Settings value)  $default,){
final _that = this;
switch (_that) {
case _Settings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Settings value)?  $default,){
final _that = this;
switch (_that) {
case _Settings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool soundEnabled,  bool hapticEnabled,  ThemePreferenceEnum theme,  ValidationModeEnum validationMode,  bool hintButtonVisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that.soundEnabled,_that.hapticEnabled,_that.theme,_that.validationMode,_that.hintButtonVisible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool soundEnabled,  bool hapticEnabled,  ThemePreferenceEnum theme,  ValidationModeEnum validationMode,  bool hintButtonVisible)  $default,) {final _that = this;
switch (_that) {
case _Settings():
return $default(_that.soundEnabled,_that.hapticEnabled,_that.theme,_that.validationMode,_that.hintButtonVisible);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool soundEnabled,  bool hapticEnabled,  ThemePreferenceEnum theme,  ValidationModeEnum validationMode,  bool hintButtonVisible)?  $default,) {final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that.soundEnabled,_that.hapticEnabled,_that.theme,_that.validationMode,_that.hintButtonVisible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Settings implements Settings {
  const _Settings({this.soundEnabled = true, this.hapticEnabled = true, this.theme = ThemePreferenceEnum.system, this.validationMode = ValidationModeEnum.autoCheck, this.hintButtonVisible = true});
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

@override@JsonKey() final  bool soundEnabled;
@override@JsonKey() final  bool hapticEnabled;
@override@JsonKey() final  ThemePreferenceEnum theme;
@override@JsonKey() final  ValidationModeEnum validationMode;
@override@JsonKey() final  bool hintButtonVisible;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsCopyWith<_Settings> get copyWith => __$SettingsCopyWithImpl<_Settings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Settings&&(identical(other.soundEnabled, soundEnabled) || other.soundEnabled == soundEnabled)&&(identical(other.hapticEnabled, hapticEnabled) || other.hapticEnabled == hapticEnabled)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.validationMode, validationMode) || other.validationMode == validationMode)&&(identical(other.hintButtonVisible, hintButtonVisible) || other.hintButtonVisible == hintButtonVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,soundEnabled,hapticEnabled,theme,validationMode,hintButtonVisible);

@override
String toString() {
  return 'Settings(soundEnabled: $soundEnabled, hapticEnabled: $hapticEnabled, theme: $theme, validationMode: $validationMode, hintButtonVisible: $hintButtonVisible)';
}


}

/// @nodoc
abstract mixin class _$SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$SettingsCopyWith(_Settings value, $Res Function(_Settings) _then) = __$SettingsCopyWithImpl;
@override @useResult
$Res call({
 bool soundEnabled, bool hapticEnabled, ThemePreferenceEnum theme, ValidationModeEnum validationMode, bool hintButtonVisible
});




}
/// @nodoc
class __$SettingsCopyWithImpl<$Res>
    implements _$SettingsCopyWith<$Res> {
  __$SettingsCopyWithImpl(this._self, this._then);

  final _Settings _self;
  final $Res Function(_Settings) _then;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? soundEnabled = null,Object? hapticEnabled = null,Object? theme = null,Object? validationMode = null,Object? hintButtonVisible = null,}) {
  return _then(_Settings(
soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,hapticEnabled: null == hapticEnabled ? _self.hapticEnabled : hapticEnabled // ignore: cast_nullable_to_non_nullable
as bool,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemePreferenceEnum,validationMode: null == validationMode ? _self.validationMode : validationMode // ignore: cast_nullable_to_non_nullable
as ValidationModeEnum,hintButtonVisible: null == hintButtonVisible ? _self.hintButtonVisible : hintButtonVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
