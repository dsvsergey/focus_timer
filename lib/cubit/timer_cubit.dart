import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../models/timer_state.dart';
import '../models/timer_session.dart';
import '../models/app_settings.dart';
import '../repositories/database_repository.dart';
import '../services/notification_service.dart';
import '../services/macos_service.dart';

@injectable
class TimerCubit extends Cubit<TimerState> {
  TimerCubit(
    this._databaseRepository,
    this._notificationService,
    this._macosService,
  ) : super(const TimerState());

  final DatabaseRepository _databaseRepository;
  final NotificationService _notificationService;
  final MacOSService _macosService;
  Timer? _timer;
  AppSettings? _settings;

  Future<void> initialize() async {
    await _notificationService.initialize();
    await _macosService.initialize();

    _settings = await _databaseRepository.getSettings();

    // Try to restore previous state
    final savedState = await _databaseRepository.getTimerState();
    if (savedState != null) {
      // Restore state from database
      final status = savedState.wasRunning
          ? TimerStatus
                .paused // Don't auto-resume, let user start manually
          : savedState.wasPaused
          ? TimerStatus.paused
          : TimerStatus.idle;

      emit(
        state.copyWith(
          currentSessionType: savedState.currentSessionType,
          remainingSeconds: savedState.remainingSeconds,
          completedCycles: savedState.completedCycles,
          currentCycleStep: savedState.currentCycleStep,
          totalFocusSessions: savedState.totalFocusSessions,
          status: status,
        ),
      );
    } else {
      // Set initial timer duration based on settings
      emit(
        state.copyWith(remainingSeconds: (_settings?.focusDuration ?? 25) * 60),
      );
    }

    // Set up method channel for macOS commands
    if (Platform.isMacOS) {
      const channel = MethodChannel('focus_timer/macos');
      channel.setMethodCallHandler((call) async {
        switch (call.method) {
          case 'pauseTimer':
            pauseTimer();
            break;
          case 'resumeTimer':
            await resumeTimer();
            break;
        }
      });
    }

    // Show menu bar icon and update with initial time
    await _macosService.showMenuBarIcon();
    await _updateMacOSDisplay();
    await _updateMacOSMenuItems();
  }

  void startTimer() {
    if (state.status == TimerStatus.idle ||
        state.status == TimerStatus.paused) {
      _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
      emit(state.copyWith(status: TimerStatus.running));
      _saveState();
      _updateMacOSDisplay();
      _updateMacOSMenuItems();
    }
  }

  void pauseTimer() {
    if (state.status == TimerStatus.running) {
      _timer?.cancel();
      emit(state.copyWith(status: TimerStatus.paused));
      _saveState();
      _updateMacOSDisplayForPause();
      _updateMacOSMenuItems();
    }
  }

  Future<void> resumeTimer() async {
    if (state.status == TimerStatus.paused) {
      _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
      emit(state.copyWith(status: TimerStatus.running));
      _saveState();
      await _macosService.updateMenuBarForResume();
      await _updateMacOSDisplay();
      await _updateMacOSMenuItems();
    }
  }

  void resetTimer() {
    _timer?.cancel();
    final duration = _getDurationForSessionType(state.currentSessionType);
    emit(
      state.copyWith(status: TimerStatus.idle, remainingSeconds: duration * 60),
    );
    _saveState();
    _updateMacOSDisplay();
    _updateMacOSMenuItems();
  }

  void skipSession() {
    _timer?.cancel();
    _onSessionComplete(completed: false);
  }

  void _onTick(Timer timer) {
    if (state.remainingSeconds > 0) {
      emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
      _updateMacOSDisplay();
    } else {
      _timer?.cancel();
      _onSessionComplete(completed: true);
    }
  }

  Future<void> _updateMacOSDisplay() async {
    // Don't update if paused - let pause display remain
    if (state.status == TimerStatus.paused) {
      return;
    }

    final timeString = getFormattedTime();
    final statusEmoji = _getStatusEmoji();

    // Update dock badge with time
    await _macosService.updateDockBadge(timeString);

    // Update menu bar with status and time
    await _macosService.updateMenuBarTitle('$statusEmoji $timeString');
  }

  String _getStatusEmoji() {
    return switch (state.currentSessionType) {
      SessionType.focus => '🍅', // Tomato for Pomodoro
      SessionType.shortBreak => '☕', // Coffee for short break
      SessionType.longBreak => '🌱', // Plant for long break
    };
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

    // Save the updated state
    await _saveState();

    // Update macOS display with new session
    await _updateMacOSDisplay();
    await _updateMacOSMenuItems();
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

  Future<void> _updateMacOSDisplayForPause() async {
    // Show pause symbols in menu bar and dock badge
    await _macosService.updateMenuBarForPause();
  }

  Future<void> _updateMacOSMenuItems() async {
    final isRunning =
        state.status == TimerStatus.running ||
        state.status == TimerStatus.paused;
    final isPaused = state.status == TimerStatus.paused;

    await _macosService.updateMenuItems(
      isRunning: isRunning,
      isPaused: isPaused,
    );
  }

  Future<void> _saveState() async {
    try {
      await _databaseRepository.saveTimerState(state);
    } catch (e) {
      debugPrint('Error saving timer state: $e');
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _saveState(); // Save state before closing
    _macosService.clearDockBadge();
    _macosService.hideMenuBarIcon();
    return super.close();
  }
}
