import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/timer_cubit.dart';
import '../models/timer_state.dart';

class TimerControls extends StatelessWidget {
  const TimerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Reset button
            _buildControlButton(
              onPressed: () => context.read<TimerCubit>().resetTimer(),
              icon: Icons.refresh,
              backgroundColor: Colors.white.withOpacity(0.1),
              foregroundColor: Colors.white,
            ),

            const SizedBox(width: 20),

            // Main play/pause button
            _buildMainButton(
              onPressed: _getMainButtonAction(context, state),
              icon: _getMainButtonIcon(state.status),
              text: _getMainButtonText(state.status),
            ),

            const SizedBox(width: 20),

            // Skip button
            _buildControlButton(
              onPressed: () => context.read<TimerCubit>().skipSession(),
              icon: Icons.skip_next,
              backgroundColor: Colors.white.withOpacity(0.1),
              foregroundColor: Colors.white,
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String text,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: const Color(0xFF2E7D9A)),
            const SizedBox(height: 4),
            Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2E7D9A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(color: foregroundColor.withOpacity(0.3), width: 1),
        ),
        child: Icon(icon, size: 24, color: foregroundColor),
      ),
    );
  }

  VoidCallback _getMainButtonAction(BuildContext context, TimerState state) {
    switch (state.status) {
      case TimerStatus.idle:
      case TimerStatus.paused:
        return () => context.read<TimerCubit>().startTimer();
      case TimerStatus.running:
        return () => context.read<TimerCubit>().pauseTimer();
      case TimerStatus.completed:
        return () => context.read<TimerCubit>().resetTimer();
    }
  }

  IconData _getMainButtonIcon(TimerStatus status) {
    switch (status) {
      case TimerStatus.idle:
      case TimerStatus.paused:
        return Icons.play_arrow;
      case TimerStatus.running:
        return Icons.pause;
      case TimerStatus.completed:
        return Icons.refresh;
    }
  }

  String _getMainButtonText(TimerStatus status) {
    switch (status) {
      case TimerStatus.idle:
        return 'START';
      case TimerStatus.paused:
        return 'RESUME';
      case TimerStatus.running:
        return 'PAUSE';
      case TimerStatus.completed:
        return 'RESET';
    }
  }
}
