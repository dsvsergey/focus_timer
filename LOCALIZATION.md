# 🌍 Локалізація Focus Timer

Додаток підтримує **англійську** та **українську** мови.

## 📁 Структура локалізації

```
lib/
├── l10n/
│   ├── app_en.arb          # Англійські переклади
│   ├── app_uk.arb          # Українські переклади
│   └── app_localizations.dart  # Згенерований файл
└── l10n.yaml               # Конфігурація локалізації
```

## 🔧 Налаштування

### 1. Залежності в `pubspec.yaml`

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2

flutter:
  generate: true
```

### 2. Конфігурація в `l10n.yaml`

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

### 3. MaterialApp налаштування

```dart
MaterialApp(
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('en'),
    Locale('uk'),
  ],
  // ...
)
```

## 🎯 Використання у коді

```dart
// Отримати локалізовані рядки
final l10n = AppLocalizations.of(context)!;

// Використовувати
Text(l10n.focus),
Text(l10n.shortBreak),
Text(l10n.start),
```

## 📝 Додавання нових перекладів

1. Додати ключ у `app_en.arb`:

```json
{
  "newString": "New String"
}
```

2. Додати переклад у `app_uk.arb`:

```json
{
  "newString": "Новий Рядок"
}
```

3. Згенерувати код:

```bash
flutter gen-l10n
```

## 🔄 Автоматичне визначення мови

Додаток автоматично визначає мову системи. Якщо система українська — відображається українська, інакше — англійська.

## 🌍 Підтримувані мови

- 🇺🇸 **English** (en)
- 🇺🇦 **Українська** (uk)

Для додавання нової мови:

1. Створити файл `app_[код_мови].arb`
2. Додати `Locale('[код_мови]')` у `supportedLocales`
3. Згенерувати код командою `flutter gen-l10n`
