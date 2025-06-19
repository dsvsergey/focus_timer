# 🏗️ Dependency Injection в Focus Timer

Додаток використовує **GetIt** + **injectable** для управління залежностями.

## 📁 Структура DI

```
lib/
├── core/
│   ├── injection.dart          # Конфігурація DI
│   └── injection.config.dart   # Згенерований файл
├── services/
│   └── notification_service.dart  # Сервіс сповіщень
├── repositories/
│   └── database_repository.dart   # Репозиторій БД
└── cubit/
    └── timer_cubit.dart          # Cubit з DI
```

## 🔧 Налаштування

### 1. Залежності в `pubspec.yaml`

```yaml
dependencies:
  get_it: ^8.0.2
  injectable: ^2.4.4

dev_dependencies:
  injectable_generator: ^2.4.2
  build_runner: ^2.4.13
```

### 2. Конфігурація DI в `core/injection.dart`

```dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
```

### 3. Ініціалізація в `main.dart`

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(); // 🔧 Ініціалізація DI
  runApp(const FocusTimerApp());
}
```

## 📦 Зареєстровані сервіси

### 🗄️ **DatabaseRepository** (`@singleton`)

```dart
@singleton
class DatabaseRepository {
  // Єдиний екземпляр для всього додатку
}
```

### 🔔 **NotificationService** (`@singleton`)

```dart
@singleton
class NotificationService {
  // Управління push-сповіщеннями
}
```

### 🎯 **TimerCubit** (`@injectable`)

```dart
@injectable
class TimerCubit extends Cubit<TimerState> {
  TimerCubit(
    this._databaseRepository,
    this._notificationService,
  ) : super(const TimerState());
}
```

## 🎯 Використання

### Отримання сервісу

```dart
// У main.dart
BlocProvider(
  create: (context) => getIt<TimerCubit>()..initialize(),
  child: const TimerScreen(),
)

// В іншому місці
final repository = getIt<DatabaseRepository>();
final notificationService = getIt<NotificationService>();
```

### Ін'єкція залежностей в конструктор

```dart
@injectable
class MyService {
  MyService(
    this._databaseRepository,  // ✅ Автоматично ін'єктується
    this._notificationService, // ✅ Автоматично ін'єктується
  );

  final DatabaseRepository _databaseRepository;
  final NotificationService _notificationService;
}
```

## 🔄 Генерація коду

Після додавання нових сервісів:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 📋 Типи реєстрації

- **`@singleton`** - Єдиний екземпляр (Singleton)
- **`@injectable`** - Новий екземпляр при кожному запиті
- **`@lazySingleton`** - Lazy Singleton (створюється при першому запиті)

## ✅ Переваги DI

1. **🔧 Тестування** - Легко підміняти залежності в тестах
2. **🏗️ Розділення відповідальностей** - Кожен клас має одну відповідальність
3. **🔄 Управління життєвим циклом** - Автоматичне управління екземплярами
4. **📈 Масштабованість** - Легко додавати нові сервіси

## 🧪 Приклад тестування

```dart
void main() {
  setUp(() {
    // Очищуємо GetIt для тестів
    getIt.reset();
    
    // Реєструємо mock'и
    getIt.registerSingleton<DatabaseRepository>(MockDatabaseRepository());
    getIt.registerSingleton<NotificationService>(MockNotificationService());
  });

  test('TimerCubit should work with mocked dependencies', () {
    final cubit = getIt<TimerCubit>();
    // Тестування...
  });
}
```
