import 'package:isar/isar.dart';
import 'timer_session.dart';

part 'timer_persistence.g.dart';

@Collection()
class TimerPersistence {
  Id id = 1; // Завжди використовуємо ID 1 як singleton

  @Enumerated(EnumType.name)
  SessionType currentSessionType = SessionType.focus;

  int remainingSeconds = 1500; // 25 minutes default
  int completedCycles = 0;
  int currentCycleStep = 0;
  int totalFocusSessions = 0;
  bool wasRunning = false;
  bool wasPaused = false;
  DateTime lastSaveTime = DateTime.now();
}
