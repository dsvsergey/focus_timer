import 'dart:io';
import 'package:flutter/material.dart';
import '../core/injection.dart';
import '../services/window_service.dart';

class WindowControls extends StatelessWidget {
  const WindowControls({super.key});

  @override
  Widget build(BuildContext context) {
    final windowService = getIt<WindowService>();

    // Only show on non-macOS platforms (macOS has native menu bar)
    if (Platform.isMacOS) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Minimize to system tray button
          IconButton(
            onPressed: () async {
              await windowService.hideWindowWithAnimation(context);
            },
            icon: const Icon(Icons.minimize, color: Colors.white70, size: 18),
            tooltip: 'Minimize to system tray',
          ),
        ],
      ),
    );
  }
}
