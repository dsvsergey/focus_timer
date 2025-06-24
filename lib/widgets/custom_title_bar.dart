import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'window_controls.dart';

class CustomTitleBar extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;

  const CustomTitleBar({
    super.key,
    required this.title,
    this.backgroundColor = const Color(0xFF2E7D9A),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    // Only show custom title bar on desktop platforms
    if (!Platform.isWindows && !Platform.isMacOS && !Platform.isLinux) {
      return const SizedBox.shrink();
    }

    return Container(
      height: Platform.isMacOS ? 28 : 32,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Draggable area
          Expanded(
            child: GestureDetector(
              onPanStart: Platform.isWindows ? _onPanStart : null,
              onPanUpdate: Platform.isWindows ? _onPanUpdate : null,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Platform.isMacOS
                    ? Stack(
                        children: [
                          // Perfectly centered title for macOS
                          Center(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),

          // Window controls and close button
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Custom window controls (minimize to tray)
              const WindowControls(),

              // Close button (for Windows and Linux, macOS handles this natively)
              if (Platform.isWindows || Platform.isLinux) _buildCloseButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _closeWindow,
        onHover: (hovered) {
          // Could add hover effect here
        },
        child: Container(
          width: 46,
          height: 32,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Icon(Icons.close, color: textColor, size: 16),
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    // Start window drag on Windows
    if (Platform.isWindows) {
      const channel = MethodChannel('focus_timer/window');
      channel.invokeMethod('startDrag');
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    // Handle window dragging on Windows
    if (Platform.isWindows) {
      const channel = MethodChannel('focus_timer/window');
      channel.invokeMethod('dragWindow', {
        'deltaX': details.delta.dx,
        'deltaY': details.delta.dy,
      });
    }
  }

  void _closeWindow() {
    if (Platform.isWindows) {
      const channel = MethodChannel('focus_timer/window');
      channel.invokeMethod('closeWindow');
    } else {
      // For Linux and other platforms, use standard exit
      SystemNavigator.pop();
    }
  }
}
