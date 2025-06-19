// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimerState {
  TimerStatus get status => throw _privateConstructorUsedError;
  SessionType get currentSessionType => throw _privateConstructorUsedError;
  int get remainingSeconds => throw _privateConstructorUsedError;
  int get completedCycles => throw _privateConstructorUsedError;
  int get currentCycleStep =>
      throw _privateConstructorUsedError; // 0-3 (4 focus sessions)
  int get totalFocusSessions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimerStateCopyWith<TimerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerStateCopyWith<$Res> {
  factory $TimerStateCopyWith(
          TimerState value, $Res Function(TimerState) then) =
      _$TimerStateCopyWithImpl<$Res, TimerState>;
  @useResult
  $Res call(
      {TimerStatus status,
      SessionType currentSessionType,
      int remainingSeconds,
      int completedCycles,
      int currentCycleStep,
      int totalFocusSessions});
}

/// @nodoc
class _$TimerStateCopyWithImpl<$Res, $Val extends TimerState>
    implements $TimerStateCopyWith<$Res> {
  _$TimerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentSessionType = null,
    Object? remainingSeconds = null,
    Object? completedCycles = null,
    Object? currentCycleStep = null,
    Object? totalFocusSessions = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TimerStatus,
      currentSessionType: null == currentSessionType
          ? _value.currentSessionType
          : currentSessionType // ignore: cast_nullable_to_non_nullable
              as SessionType,
      remainingSeconds: null == remainingSeconds
          ? _value.remainingSeconds
          : remainingSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      completedCycles: null == completedCycles
          ? _value.completedCycles
          : completedCycles // ignore: cast_nullable_to_non_nullable
              as int,
      currentCycleStep: null == currentCycleStep
          ? _value.currentCycleStep
          : currentCycleStep // ignore: cast_nullable_to_non_nullable
              as int,
      totalFocusSessions: null == totalFocusSessions
          ? _value.totalFocusSessions
          : totalFocusSessions // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimerStateImplCopyWith<$Res>
    implements $TimerStateCopyWith<$Res> {
  factory _$$TimerStateImplCopyWith(
          _$TimerStateImpl value, $Res Function(_$TimerStateImpl) then) =
      __$$TimerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TimerStatus status,
      SessionType currentSessionType,
      int remainingSeconds,
      int completedCycles,
      int currentCycleStep,
      int totalFocusSessions});
}

/// @nodoc
class __$$TimerStateImplCopyWithImpl<$Res>
    extends _$TimerStateCopyWithImpl<$Res, _$TimerStateImpl>
    implements _$$TimerStateImplCopyWith<$Res> {
  __$$TimerStateImplCopyWithImpl(
      _$TimerStateImpl _value, $Res Function(_$TimerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentSessionType = null,
    Object? remainingSeconds = null,
    Object? completedCycles = null,
    Object? currentCycleStep = null,
    Object? totalFocusSessions = null,
  }) {
    return _then(_$TimerStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TimerStatus,
      currentSessionType: null == currentSessionType
          ? _value.currentSessionType
          : currentSessionType // ignore: cast_nullable_to_non_nullable
              as SessionType,
      remainingSeconds: null == remainingSeconds
          ? _value.remainingSeconds
          : remainingSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      completedCycles: null == completedCycles
          ? _value.completedCycles
          : completedCycles // ignore: cast_nullable_to_non_nullable
              as int,
      currentCycleStep: null == currentCycleStep
          ? _value.currentCycleStep
          : currentCycleStep // ignore: cast_nullable_to_non_nullable
              as int,
      totalFocusSessions: null == totalFocusSessions
          ? _value.totalFocusSessions
          : totalFocusSessions // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TimerStateImpl implements _TimerState {
  const _$TimerStateImpl(
      {this.status = TimerStatus.idle,
      this.currentSessionType = SessionType.focus,
      this.remainingSeconds = 0,
      this.completedCycles = 0,
      this.currentCycleStep = 0,
      this.totalFocusSessions = 0});

  @override
  @JsonKey()
  final TimerStatus status;
  @override
  @JsonKey()
  final SessionType currentSessionType;
  @override
  @JsonKey()
  final int remainingSeconds;
  @override
  @JsonKey()
  final int completedCycles;
  @override
  @JsonKey()
  final int currentCycleStep;
// 0-3 (4 focus sessions)
  @override
  @JsonKey()
  final int totalFocusSessions;

  @override
  String toString() {
    return 'TimerState(status: $status, currentSessionType: $currentSessionType, remainingSeconds: $remainingSeconds, completedCycles: $completedCycles, currentCycleStep: $currentCycleStep, totalFocusSessions: $totalFocusSessions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentSessionType, currentSessionType) ||
                other.currentSessionType == currentSessionType) &&
            (identical(other.remainingSeconds, remainingSeconds) ||
                other.remainingSeconds == remainingSeconds) &&
            (identical(other.completedCycles, completedCycles) ||
                other.completedCycles == completedCycles) &&
            (identical(other.currentCycleStep, currentCycleStep) ||
                other.currentCycleStep == currentCycleStep) &&
            (identical(other.totalFocusSessions, totalFocusSessions) ||
                other.totalFocusSessions == totalFocusSessions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, currentSessionType,
      remainingSeconds, completedCycles, currentCycleStep, totalFocusSessions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerStateImplCopyWith<_$TimerStateImpl> get copyWith =>
      __$$TimerStateImplCopyWithImpl<_$TimerStateImpl>(this, _$identity);
}

abstract class _TimerState implements TimerState {
  const factory _TimerState(
      {final TimerStatus status,
      final SessionType currentSessionType,
      final int remainingSeconds,
      final int completedCycles,
      final int currentCycleStep,
      final int totalFocusSessions}) = _$TimerStateImpl;

  @override
  TimerStatus get status;
  @override
  SessionType get currentSessionType;
  @override
  int get remainingSeconds;
  @override
  int get completedCycles;
  @override
  int get currentCycleStep;
  @override // 0-3 (4 focus sessions)
  int get totalFocusSessions;
  @override
  @JsonKey(ignore: true)
  _$$TimerStateImplCopyWith<_$TimerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
