// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppSettings {
  int get id => throw _privateConstructorUsedError;
  int get focusDuration => throw _privateConstructorUsedError; // in minutes
  int get shortBreakDuration =>
      throw _privateConstructorUsedError; // in minutes
  int get longBreakDuration => throw _privateConstructorUsedError; // in minutes
  bool get soundEnabled => throw _privateConstructorUsedError;
  bool get vibrationEnabled => throw _privateConstructorUsedError;
  bool get notificationsEnabled => throw _privateConstructorUsedError;
  bool get darkTheme => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {int id,
      int focusDuration,
      int shortBreakDuration,
      int longBreakDuration,
      bool soundEnabled,
      bool vibrationEnabled,
      bool notificationsEnabled,
      bool darkTheme});
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? focusDuration = null,
    Object? shortBreakDuration = null,
    Object? longBreakDuration = null,
    Object? soundEnabled = null,
    Object? vibrationEnabled = null,
    Object? notificationsEnabled = null,
    Object? darkTheme = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      focusDuration: null == focusDuration
          ? _value.focusDuration
          : focusDuration // ignore: cast_nullable_to_non_nullable
              as int,
      shortBreakDuration: null == shortBreakDuration
          ? _value.shortBreakDuration
          : shortBreakDuration // ignore: cast_nullable_to_non_nullable
              as int,
      longBreakDuration: null == longBreakDuration
          ? _value.longBreakDuration
          : longBreakDuration // ignore: cast_nullable_to_non_nullable
              as int,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _value.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      darkTheme: null == darkTheme
          ? _value.darkTheme
          : darkTheme // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
          _$AppSettingsImpl value, $Res Function(_$AppSettingsImpl) then) =
      __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int focusDuration,
      int shortBreakDuration,
      int longBreakDuration,
      bool soundEnabled,
      bool vibrationEnabled,
      bool notificationsEnabled,
      bool darkTheme});
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? focusDuration = null,
    Object? shortBreakDuration = null,
    Object? longBreakDuration = null,
    Object? soundEnabled = null,
    Object? vibrationEnabled = null,
    Object? notificationsEnabled = null,
    Object? darkTheme = null,
  }) {
    return _then(_$AppSettingsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      focusDuration: null == focusDuration
          ? _value.focusDuration
          : focusDuration // ignore: cast_nullable_to_non_nullable
              as int,
      shortBreakDuration: null == shortBreakDuration
          ? _value.shortBreakDuration
          : shortBreakDuration // ignore: cast_nullable_to_non_nullable
              as int,
      longBreakDuration: null == longBreakDuration
          ? _value.longBreakDuration
          : longBreakDuration // ignore: cast_nullable_to_non_nullable
              as int,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _value.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      darkTheme: null == darkTheme
          ? _value.darkTheme
          : darkTheme // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AppSettingsImpl extends _AppSettings {
  const _$AppSettingsImpl(
      {this.id = 1,
      this.focusDuration = 25,
      this.shortBreakDuration = 5,
      this.longBreakDuration = 15,
      this.soundEnabled = true,
      this.vibrationEnabled = true,
      this.notificationsEnabled = true,
      this.darkTheme = false})
      : super._();

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int focusDuration;
// in minutes
  @override
  @JsonKey()
  final int shortBreakDuration;
// in minutes
  @override
  @JsonKey()
  final int longBreakDuration;
// in minutes
  @override
  @JsonKey()
  final bool soundEnabled;
  @override
  @JsonKey()
  final bool vibrationEnabled;
  @override
  @JsonKey()
  final bool notificationsEnabled;
  @override
  @JsonKey()
  final bool darkTheme;

  @override
  String toString() {
    return 'AppSettings(id: $id, focusDuration: $focusDuration, shortBreakDuration: $shortBreakDuration, longBreakDuration: $longBreakDuration, soundEnabled: $soundEnabled, vibrationEnabled: $vibrationEnabled, notificationsEnabled: $notificationsEnabled, darkTheme: $darkTheme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.focusDuration, focusDuration) ||
                other.focusDuration == focusDuration) &&
            (identical(other.shortBreakDuration, shortBreakDuration) ||
                other.shortBreakDuration == shortBreakDuration) &&
            (identical(other.longBreakDuration, longBreakDuration) ||
                other.longBreakDuration == longBreakDuration) &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled) &&
            (identical(other.vibrationEnabled, vibrationEnabled) ||
                other.vibrationEnabled == vibrationEnabled) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.darkTheme, darkTheme) ||
                other.darkTheme == darkTheme));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      focusDuration,
      shortBreakDuration,
      longBreakDuration,
      soundEnabled,
      vibrationEnabled,
      notificationsEnabled,
      darkTheme);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);
}

abstract class _AppSettings extends AppSettings {
  const factory _AppSettings(
      {final int id,
      final int focusDuration,
      final int shortBreakDuration,
      final int longBreakDuration,
      final bool soundEnabled,
      final bool vibrationEnabled,
      final bool notificationsEnabled,
      final bool darkTheme}) = _$AppSettingsImpl;
  const _AppSettings._() : super._();

  @override
  int get id;
  @override
  int get focusDuration;
  @override // in minutes
  int get shortBreakDuration;
  @override // in minutes
  int get longBreakDuration;
  @override // in minutes
  bool get soundEnabled;
  @override
  bool get vibrationEnabled;
  @override
  bool get notificationsEnabled;
  @override
  bool get darkTheme;
  @override
  @JsonKey(ignore: true)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
