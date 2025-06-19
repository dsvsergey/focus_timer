import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/timer_state.dart';
import '../models/timer_session.dart';
import '../models/app_settings.dart';
import '../repositories/database_repository.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit(this._databaseRepository) : super(const TimerState());

  final DatabaseRepository _databaseRepository;
  Timer? _timer;
  AppSettings? _settings;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _initializeNotifications();
    _settings = await _databaseRepository.getSettings();

    // Set initial timer duration based on settings
    emit(
      state.copyWith(remainingSeconds: (_settings?.focusDuration ?? 25) * 60),
    );
  }

  Future<void> _initializeNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(initSettings);
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
      await _showNotification();
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

  Future<void> _showNotification() async {
    String title;
    String body;

    switch (state.currentSessionType) {
      case SessionType.focus:
        title = 'Focus Session Complete!';
        body = 'Great job! Time for a break.';
        break;
      case SessionType.shortBreak:
        title = 'Break Complete!';
        body = 'Ready to focus again?';
        break;
      case SessionType.longBreak:
        title = 'Long Break Complete!';
        body = 'You\'ve completed a full Pomodoro cycle!';
        break;
    }

    const androidDetails = AndroidNotificationDetails(
      'timer_channel',
      'Timer Notifications',
      channelDescription: 'Notifications for timer completion',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(0, title, body, notificationDetails);
  }

  String getSessionTypeTitle() {
    switch (state.currentSessionType) {
      case SessionType.focus:
        return 'Focus';
      case SessionType.shortBreak:
        return 'Short Break';
      case SessionType.longBreak:
        return 'Long Break';
    }
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
