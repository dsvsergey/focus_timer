import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import '../models/timer_session.dart';

@singleton
class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
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

    await _plugin.initialize(initSettings);
  }

  Future<void> showSessionCompleteNotification(SessionType sessionType) async {
    String title;
    String body;

    switch (sessionType) {
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

    await _plugin.show(0, title, body, notificationDetails);
  }
}
