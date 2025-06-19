import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../models/timer_state.dart';
import '../models/timer_session.dart';
import '../models/app_settings.dart';
import '../repositories/database_repository.dart';
import '../services/notification_service.dart';

@injectable
class TimerCubit extends Cubit<TimerState> {
  TimerCubit(this._databaseRepository, this._notificationService)
    : super(const TimerState());

  final DatabaseRepository _databaseRepository;
  final NotificationService _notificationService;
  Timer? _timer;
  AppSettings? _settings;

  Future<void> initialize() async {
    await _notificationService.initialize();
    _settings = await _databaseRepository.getSettings();

    // Set initial timer duration based on settings
    emit(
      state.copyWith(remainingSeconds: (_settings?.focusDuration ?? 25) * 60),
    );
  }

  void startTimer() {
    if (state.status == TimerStatus.idle ||
        state.status == TimerStatus.paused) {
      _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
      emit(state.copyWith(status: TimerStatus.running));
    }
  }

  void pauseTimer() {
    if (state.status == TimerStatus.running) {
      _timer?.cancel();
      emit(state.copyWith(status: TimerStatus.paused));
    }
  }

  void resetTimer() {
    _timer?.cancel();
    final duration = _getDurationForSessionType(state.currentSessionType);
    emit(
      state.copyWith(status: TimerStatus.idle, remainingSeconds: duration * 60),
    );
  }

  void skipSession() {
    _timer?.cancel();
    _onSessionComplete(completed: false);
  }

  void _onTick(Timer timer) {
    if (state.remainingSeconds > 0) {
      emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
    } else {
      _timer?.cancel();
      _onSessionComplete(completed: true);
    }
  }

  Future<void> _onSessionComplete({required bool completed}) async {
    emit(state.copyWith(status: TimerStatus.completed));

    // Save session to database
    final session = TimerSession(
      date: DateTime.now(),
      type: state.currentSessionType,
      duration: _getDurationForSessionType(state.currentSessionType),
      completed: completed,
    );
    await _databaseRepository.saveSession(session);

    // Show notification
    if (completed && (_settings?.notificationsEnabled ?? true)) {
      await _notificationService.showSessionCompleteNotification(
        state.currentSessionType,
      );
    }

    // Determine next session type
    final nextSessionType = _getNextSessionType();
    final nextDuration = _getDurationForSessionType(nextSessionType);

    // Update cycle progress
    int newCompletedCycles = state.completedCycles;
    int newCycleStep = state.currentCycleStep;
    int newTotalFocusSessions = state.totalFocusSessions;

    if (completed && state.currentSessionType == SessionType.focus) {
      newCycleStep = (state.currentCycleStep + 1) % 4;
      newTotalFocusSessions = state.totalFocusSessions + 1;

      if (newCycleStep == 0) {
        newCompletedCycles = state.completedCycles + 1;
      }
    }

    emit(
      state.copyWith(
        status: TimerStatus.idle,
        currentSessionType: nextSessionType,
        remainingSeconds: nextDuration * 60,
        completedCycles: newCompletedCycles,
        currentCycleStep: newCycleStep,
        totalFocusSessions: newTotalFocusSessions,
      ),
    );
  }

  SessionType _getNextSessionType() {
    switch (state.currentSessionType) {
      case SessionType.focus:
        // After 4th focus session, take long break
        return (state.currentCycleStep + 1) % 4 == 0
            ? SessionType.longBreak
            : SessionType.shortBreak;
      case SessionType.shortBreak:
      case SessionType.longBreak:
        return SessionType.focus;
    }
  }

  int _getDurationForSessionType(SessionType type) {
    switch (type) {
      case SessionType.focus:
        return _settings?.focusDuration ?? 25;
      case SessionType.shortBreak:
        return _settings?.shortBreakDuration ?? 5;
      case SessionType.longBreak:
        return _settings?.longBreakDuration ?? 15;
    }
  }

  String getSessionTypeTitle(
    String focus,
    String shortBreak,
    String longBreak,
  ) {
    return switch (state.currentSessionType) {
      SessionType.focus => focus,
      SessionType.shortBreak => shortBreak,
      SessionType.longBreak => longBreak,
    };
  }

  String getFormattedTime() {
    final minutes = state.remainingSeconds ~/ 60;
    final seconds = state.remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
