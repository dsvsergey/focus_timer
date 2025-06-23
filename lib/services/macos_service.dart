import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class MacOSService {
  static const _channel = MethodChannel('focus_timer/macos');
  bool _nativeTimerActive = false;

  Future<void> initialize() async {
    if (!Platform.isMacOS) return;

    try {
      // Initialize native macOS functionality
      await _channel.invokeMethod('initialize');

      if (kDebugMode) {
        print('MacOS service initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('MacOS service initialization error: $e');
      }
    }
  }

  Future<void> updateDockBadge(String text) async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('updateDockBadge', {'text': text});
    } catch (e) {
      if (kDebugMode) {
        print('Error updating dock badge: $e');
      }
    }
  }

  Future<void> clearDockBadge() async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('clearDockBadge');
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing dock badge: $e');
      }
    }
  }

  Future<void> showMenuBarIcon() async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('showMenuBarIcon');
    } catch (e) {
      if (kDebugMode) {
        print('Error showing menu bar icon: $e');
      }
    }
  }

  Future<void> hideMenuBarIcon() async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('hideMenuBarIcon');
    } catch (e) {
      if (kDebugMode) {
        print('Error hiding menu bar icon: $e');
      }
    }
  }

  Future<void> updateMenuBarTitle(String title) async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('updateMenuBarTitle', {'title': title});
    } catch (e) {
      if (kDebugMode) {
        print('Error updating menu bar title: $e');
      }
    }
  }

  Future<void> updateMenuBarForPause() async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('updateMenuBarForPause');
    } catch (e) {
      if (kDebugMode) {
        print('Error updating menu bar for pause: $e');
      }
    }
  }

  Future<void> updateMenuBarForResume() async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('updateMenuBarForResume');
    } catch (e) {
      if (kDebugMode) {
        print('Error updating menu bar for resume: $e');
      }
    }
  }

  Future<void> updateMenuItems({
    required bool isRunning,
    required bool isPaused,
  }) async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('updateMenuItems', {
        'isRunning': isRunning,
        'isPaused': isPaused,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error updating menu items: $e');
      }
    }
  }

  // Native timer methods for background operation
  Future<void> startNativeTimer({
    required int remainingSeconds,
    required String sessionType,
  }) async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('startNativeTimer', {
        'remainingSeconds': remainingSeconds,
        'sessionType': sessionType,
      });
      _nativeTimerActive = true;
    } catch (e) {
      if (kDebugMode) {
        print('Error starting native timer: $e');
      }
    }
  }

  Future<void> stopNativeTimer() async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('stopNativeTimer');
      _nativeTimerActive = false;
    } catch (e) {
      if (kDebugMode) {
        print('Error stopping native timer: $e');
      }
    }
  }

  Future<void> updateNativeTimer({
    required int remainingSeconds,
    required String sessionType,
  }) async {
    if (!Platform.isMacOS) return;

    try {
      await _channel.invokeMethod('updateNativeTimer', {
        'remainingSeconds': remainingSeconds,
        'sessionType': sessionType,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error updating native timer: $e');
      }
    }
  }

  bool get isNativeTimerActive => _nativeTimerActive;
}
