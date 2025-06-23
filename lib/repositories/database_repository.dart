import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';
import '../models/timer_session.dart';
import '../models/app_settings.dart';
import '../models/timer_state.dart';
import '../models/timer_persistence.dart';

@singleton
class DatabaseRepository {
  static Isar? _isar;

  static Future<Isar> get isar async {
    if (_isar != null) return _isar!;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      TimerSessionSchema,
      AppSettingsSchema,
      TimerPersistenceSchema,
    ], directory: dir.path);
    return _isar!;
  }

  // Settings operations
  Future<AppSettings> getSettings() async {
    final db = await isar;
    final settings = await db.appSettings.get(1);
    return settings ?? const AppSettings();
  }

  Future<void> saveSettings(AppSettings settings) async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.appSettings.put(settings);
    });
  }

  // Timer session operations
  Future<void> saveSession(TimerSession session) async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.timerSessions.put(session);
    });
  }

  Future<List<TimerSession>> getSessionsForDate(DateTime date) async {
    final db = await isar;
    final sessions = await db.timerSessions.where().findAll();
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return sessions
        .where(
          (session) =>
              session.date.isAfter(startOfDay) &&
              session.date.isBefore(endOfDay),
        )
        .toList();
  }

  Future<List<TimerSession>> getSessionsForWeek(DateTime startDate) async {
    final db = await isar;
    final sessions = await db.timerSessions.where().findAll();
    final endDate = startDate.add(const Duration(days: 7));

    return sessions
        .where(
          (session) =>
              session.date.isAfter(startDate) && session.date.isBefore(endDate),
        )
        .toList();
  }

  Future<int> getTotalCompletedSessions() async {
    final db = await isar;
    final sessions = await db.timerSessions.where().findAll();
    return sessions.where((session) => session.completed).length;
  }

  Future<void> clearAllSessions() async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.timerSessions.clear();
    });
  }

  // Timer state persistence operations
  Future<void> saveTimerState(TimerState state) async {
    final db = await isar;
    final persistence = TimerPersistence()
      ..currentSessionType = state.currentSessionType
      ..remainingSeconds = state.remainingSeconds
      ..completedCycles = state.completedCycles
      ..currentCycleStep = state.currentCycleStep
      ..totalFocusSessions = state.totalFocusSessions
      ..wasRunning = state.status == TimerStatus.running
      ..wasPaused = state.status == TimerStatus.paused
      ..lastSaveTime = DateTime.now();

    await db.writeTxn(() async {
      await db.timerPersistences.put(persistence);
    });
  }

  Future<TimerPersistence?> getTimerState() async {
    final db = await isar;
    return await db.timerPersistences.get(1);
  }

  Future<void> clearTimerState() async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.timerPersistences.clear();
    });
  }
}
