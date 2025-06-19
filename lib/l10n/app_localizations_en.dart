// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Focus Timer';

  @override
  String get focus => 'Focus';

  @override
  String get shortBreak => 'Short Break';

  @override
  String get longBreak => 'Long Break';

  @override
  String get readyToStart => 'Ready to start';

  @override
  String get focusTime => 'Focus time';

  @override
  String get paused => 'Paused';

  @override
  String get sessionComplete => 'Session complete!';

  @override
  String get start => 'START';

  @override
  String get pause => 'PAUSE';

  @override
  String get resume => 'RESUME';

  @override
  String get reset => 'RESET';

  @override
  String get pomodoroCycle => 'Pomodoro Cycle';

  @override
  String get today => 'Today';

  @override
  String get cycles => 'Cycles';

  @override
  String get focusSessionComplete => 'Focus Session Complete!';

  @override
  String get focusSessionCompleteBody => 'Great job! Time for a break.';

  @override
  String get breakComplete => 'Break Complete!';

  @override
  String get breakCompleteBody => 'Ready to focus again?';

  @override
  String get longBreakComplete => 'Long Break Complete!';

  @override
  String get longBreakCompleteBody =>
      'You\'ve completed a full Pomodoro cycle!';

  @override
  String get settings => 'Settings';

  @override
  String get statistics => 'Statistics';

  @override
  String get focusDuration => 'Focus Duration';

  @override
  String get shortBreakDuration => 'Short Break Duration';

  @override
  String get longBreakDuration => 'Long Break Duration';

  @override
  String get minutes => 'minutes';

  @override
  String get soundEnabled => 'Sound Enabled';

  @override
  String get vibrationEnabled => 'Vibration Enabled';

  @override
  String get notificationsEnabled => 'Notifications Enabled';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get sessionsToday => 'Sessions Today';

  @override
  String get totalSessions => 'Total Sessions';

  @override
  String get completedCycles => 'Completed Cycles';

  @override
  String get thisWeek => 'This Week';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get motivationQuote => 'Stay focused and never give up!';
}
