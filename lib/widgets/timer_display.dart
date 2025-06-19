import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/timer_cubit.dart';
import '../models/timer_state.dart';
import '../models/timer_session.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        return Center(
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 3,
              ),
            ),
            child: Stack(
              children: [
                // Progress ring
                Positioned.fill(
                  child: CircularProgressIndicator(
                    value: _getProgress(state),
                    strokeWidth: 6,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                // Timer text
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.read<TimerCubit>().getFormattedTime(),
                        style: GoogleFonts.inter(
                          fontSize: 48,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getStatusText(state.status),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _getProgress(TimerState state) {
    final totalDuration = _getTotalDurationForSession(state);
    if (totalDuration == 0) return 0;
    return (totalDuration - state.remainingSeconds) / totalDuration;
  }

  int _getTotalDurationForSession(TimerState state) {
    // This is a simplified version - in a real app, you'd get this from settings
    switch (state.currentSessionType) {
      case SessionType.focus:
        return 25 * 60; // 25 minutes
      case SessionType.shortBreak:
        return 5 * 60; // 5 minutes
      case SessionType.longBreak:
        return 15 * 60; // 15 minutes
    }
  }

  String _getStatusText(TimerStatus status) {
    switch (status) {
      case TimerStatus.idle:
        return 'Ready to start';
      case TimerStatus.running:
        return 'Focus time';
      case TimerStatus.paused:
        return 'Paused';
      case TimerStatus.completed:
        return 'Session complete!';
    }
  }
}
