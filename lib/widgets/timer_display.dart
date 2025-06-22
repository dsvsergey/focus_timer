import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/timer_cubit.dart';
import '../models/timer_state.dart';
import '../models/timer_session.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        final minutes = state.remainingSeconds ~/ 60;
        final seconds = state.remainingSeconds % 60;
        final timeString =
            '${minutes.toString().padLeft(2, '0')}:'
            '${seconds.toString().padLeft(2, '0')}';

        return Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: CustomPaint(
              painter: CircularProgressPainter(
                progress: _calculateProgress(state),
                strokeWidth: 8,
                backgroundColor: Colors.white.withOpacity(0.2),
                progressColor: Colors.white,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timeString,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Inter',
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getStatusText(state.status),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _calculateProgress(TimerState state) {
    final totalDuration = _getTotalDuration(state);
    if (totalDuration == 0) return 0;
    return 1 - (state.remainingSeconds / totalDuration);
  }

  int _getTotalDuration(TimerState state) {
    return switch (state.currentSessionType) {
      SessionType.focus => 25 * 60, // 25 minutes
      SessionType.shortBreak => 5 * 60, // 5 minutes
      SessionType.longBreak => 15 * 60, // 15 minutes
    };
  }

  String _getStatusText(TimerStatus status) {
    return switch (status) {
      TimerStatus.idle => 'Ready to start',
      TimerStatus.running => 'In progress',
      TimerStatus.paused => 'Paused',
      TimerStatus.completed => 'Completed',
    };
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = progressColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -90 * (3.14159 / 180), // Start from top
        progress * 2 * 3.14159, // Progress angle
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
