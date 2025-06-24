import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'timer_session.freezed.dart';
part 'timer_session.g.dart';

@freezed
@Collection(ignore: {'copyWith', 'toString'})
class TimerSession with _$TimerSession {
  const TimerSession._();

  const factory TimerSession({
    Id? id,
    required DateTime date,
    @Enumerated(EnumType.name) required SessionType type,
    required int duration, // duration in minutes
    required bool completed,
  }) = _TimerSession;

  Id get isarId => id ?? Isar.autoIncrement;
}

enum SessionType { focus, shortBreak, longBreak }
