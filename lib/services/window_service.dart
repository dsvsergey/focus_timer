import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class WindowService {
  static const _macosChannel = MethodChannel('focus_timer/macos');
  static const _timerChannel = MethodChannel('focus_timer/timer');
  bool _isWindowVisible = true;

  bool get isWindowVisible => _isWindowVisible;

  Future<void> initialize() async {
    if (Platform.isMacOS) {
      await _initializeMacOS();
    }
  }

  Future<void> _initializeMacOS() async {
    try {
      // Initialize native macOS functionality
      await _macosChannel.invokeMethod('initialize');

      // Set up timer channel handler for pause/resume from menu bar
      _timerChannel.setMethodCallHandler(_handleTimerChannel);

      if (kDebugMode) {
        print('Window service initialized successfully for macOS');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Window service initialization error: $e');
      }
    }
  }

  Future<dynamic> _handleTimerChannel(MethodCall call) async {
    switch (call.method) {
      case 'toggleTimer':
        // This will be called from the menu bar
        // The actual timer logic should be handled in TimerCubit
        if (kDebugMode) {
          print('Toggle timer requested from menu bar');
        }
        return null;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'Method ${call.method} not implemented',
        );
    }
  }

  void showWindow() {
    _isWindowVisible = true;

    if (Platform.isMacOS) {
      _macosChannel.invokeMethod('showMainWindow');
      if (kDebugMode) {
        print('Requesting to show window on current active screen');
      }
    }
  }

  void hideWindow() {
    _isWindowVisible = false;

    if (Platform.isMacOS) {
      _macosChannel.invokeMethod('hideWindow');
      if (kDebugMode) {
        print('Requesting to hide window');
      }
    }
  }

  // Force show window regardless of current state
  void forceShowWindow() {
    _isWindowVisible = true;

    if (Platform.isMacOS) {
      _macosChannel.invokeMethod('showMainWindow');
      if (kDebugMode) {
        print('Force showing window on current active screen');
      }
    }
  }

  void setWindowVisible(bool visible) {
    if (visible != _isWindowVisible) {
      _isWindowVisible = visible;
    }
  }

  Future<void> updateMenuBarTitle(String title) async {
    if (Platform.isMacOS) {
      try {
        await _macosChannel.invokeMethod('updateMenuBarTitle', {
          'title': title,
        });
      } catch (e) {
        if (kDebugMode) {
          print('Error updating menu bar title: $e');
        }
      }
    }
  }

  Future<void> showMenuBarIcon() async {
    if (Platform.isMacOS) {
      try {
        await _macosChannel.invokeMethod('showMenuBarIcon');
      } catch (e) {
        if (kDebugMode) {
          print('Error showing menu bar icon: $e');
        }
      }
    }
  }

  Future<void> hideMenuBarIcon() async {
    if (Platform.isMacOS) {
      try {
        await _macosChannel.invokeMethod('hideMenuBarIcon');
      } catch (e) {
        if (kDebugMode) {
          print('Error hiding menu bar icon: $e');
        }
      }
    }
  }

  Future<void> dispose() async {
    // Cleanup if needed
  }
}
