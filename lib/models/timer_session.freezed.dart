// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimerSession {
  int? get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  @Enumerated(EnumType.name)
  SessionType get type => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError; // duration in minutes
  bool get completed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimerSessionCopyWith<TimerSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerSessionCopyWith<$Res> {
  factory $TimerSessionCopyWith(
          TimerSession value, $Res Function(TimerSession) then) =
      _$TimerSessionCopyWithImpl<$Res, TimerSession>;
  @useResult
  $Res call(
      {int? id,
      DateTime date,
      @Enumerated(EnumType.name) SessionType type,
      int duration,
      bool completed});
}

/// @nodoc
class _$TimerSessionCopyWithImpl<$Res, $Val extends TimerSession>
    implements $TimerSessionCopyWith<$Res> {
  _$TimerSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = null,
    Object? type = null,
    Object? duration = null,
    Object? completed = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SessionType,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimerSessionImplCopyWith<$Res>
    implements $TimerSessionCopyWith<$Res> {
  factory _$$TimerSessionImplCopyWith(
          _$TimerSessionImpl value, $Res Function(_$TimerSessionImpl) then) =
      __$$TimerSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      DateTime date,
      @Enumerated(EnumType.name) SessionType type,
      int duration,
      bool completed});
}

/// @nodoc
class __$$TimerSessionImplCopyWithImpl<$Res>
    extends _$TimerSessionCopyWithImpl<$Res, _$TimerSessionImpl>
    implements _$$TimerSessionImplCopyWith<$Res> {
  __$$TimerSessionImplCopyWithImpl(
      _$TimerSessionImpl _value, $Res Function(_$TimerSessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = null,
    Object? type = null,
    Object? duration = null,
    Object? completed = null,
  }) {
    return _then(_$TimerSessionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SessionType,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TimerSessionImpl extends _TimerSession {
  const _$TimerSessionImpl(
      {this.id,
      required this.date,
      @Enumerated(EnumType.name) required this.type,
      required this.duration,
      required this.completed})
      : super._();

  @override
  final int? id;
  @override
  final DateTime date;
  @override
  @Enumerated(EnumType.name)
  final SessionType type;
  @override
  final int duration;
// duration in minutes
  @override
  final bool completed;

  @override
  String toString() {
    return 'TimerSession(id: $id, date: $date, type: $type, duration: $duration, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, date, type, duration, completed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerSessionImplCopyWith<_$TimerSessionImpl> get copyWith =>
      __$$TimerSessionImplCopyWithImpl<_$TimerSessionImpl>(this, _$identity);
}

abstract class _TimerSession extends TimerSession {
  const factory _TimerSession(
      {final int? id,
      required final DateTime date,
      @Enumerated(EnumType.name) required final SessionType type,
      required final int duration,
      required final bool completed}) = _$TimerSessionImpl;
  const _TimerSession._() : super._();

  @override
  int? get id;
  @override
  DateTime get date;
  @override
  @Enumerated(EnumType.name)
  SessionType get type;
  @override
  int get duration;
  @override // duration in minutes
  bool get completed;
  @override
  @JsonKey(ignore: true)
  _$$TimerSessionImplCopyWith<_$TimerSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
