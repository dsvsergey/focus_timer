import 'package:freezed_annotation/freezed_annotation.dart';
import 'timer_session.dart';

part 'timer_state.freezed.dart';

@freezed
class TimerState with _$TimerState {
  const factory TimerState({
    @Default(TimerStatus.idle) TimerStatus status,
    @Default(SessionType.focus) SessionType currentSessionType,
    @Default(0) int remainingSeconds,
    @Default(0) int completedCycles,
    @Default(0) int currentCycleStep, // 0-3 (4 focus sessions)
    @Default(0) int totalFocusSessions,
  }) = _TimerState;
}

enum TimerStatus { idle, running, paused, completed }
