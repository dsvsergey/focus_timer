import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
@Collection(ignore: {'copyWith', 'toString'})
class AppSettings with _$AppSettings {
  const AppSettings._();

  const factory AppSettings({
    @Default(1) Id id,
    @Default(25) int focusDuration, // in minutes
    @Default(5) int shortBreakDuration, // in minutes
    @Default(15) int longBreakDuration, // in minutes
    @Default(true) bool soundEnabled,
    @Default(true) bool vibrationEnabled,
    @Default(true) bool notificationsEnabled,
    @Default(false) bool darkTheme,
  }) = _AppSettings;

  Id get isarId => id;
}
