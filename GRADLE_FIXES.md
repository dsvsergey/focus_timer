# Gradle Namespace Fixes

## Problem

When building for Android with Gradle 8.0+, the `isar_flutter_libs` package fails to build due to missing namespace configuration, causing the following error:

```
Namespace not specified. Specify a namespace in the module's build file: 
isar_flutter_libs-3.1.0+1/android/build.gradle
```

## Solution: Dependency Overrides

We use dependency overrides to maintain a local copy of `isar_flutter_libs` with the necessary fixes for Gradle 8.0+ compatibility.

### What was fixed

1. **Added namespace** to `android/build.gradle`:

   ```gradle
   android {
       namespace 'dev.isar.isar_flutter_libs'
       compileSdkVersion 34
       // ...
   }
   ```

2. **Removed package attribute** from `AndroidManifest.xml`:

   ```xml
   <manifest xmlns:android="http://schemas.android.com/apk/res/android"
       xmlns:tools="http://schemas.android.com/tools" />
   ```

3. **Updated Gradle version** from 7.3.1 to 8.1.0
4. **Updated compileSdkVersion** from 30 to 34

### Implementation

The fixes are applied using dependency overrides in `pubspec.yaml`:

```yaml
dependency_overrides:
  isar_flutter_libs:
    path: ./local_packages/isar_flutter_libs
```

This ensures that Flutter uses our fixed local copy instead of the official package from pub.dev.

### Benefits

- ✅ **Permanent solution** - survives `flutter pub get`
- ✅ **Version controlled** - team members get the same fixes
- ✅ **Maintainable** - easy to update when official fix is released
- ✅ **Backward compatible** - works with existing code

### Setup Instructions

1. The local package is already set up in `local_packages/isar_flutter_libs`
2. Dependency override is configured in `pubspec.yaml`
3. Run `flutter pub get` to apply the override
4. The override is automatically used during builds

### Future Considerations

When `isar_flutter_libs` officially supports Gradle 8.0+, remove the dependency override from `pubspec.yaml` to use the official package again.

## Related Issues

- [Flutter Gradle 8.0+ namespace errors](https://medium.com/@vortj/solving-namespace-errors-in-flutters-android-gradle-configuration-c2baa6262f8b)
- [Android Gradle Plugin migration guide](https://developer.android.com/studio/build/migrate-to-kts)
