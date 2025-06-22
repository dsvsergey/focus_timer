import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              icon: Icons.refresh,
              onPressed: () => context.read<TimerCubit>().resetTimer(),
              size: 60,
              backgroundColor: Colors.white.withOpacity(0.2),
            ),

            const SizedBox(width: 20),

            // Main play/pause button
            _buildControlButton(
              icon: state.status == TimerStatus.running
                  ? Icons.pause
                  : Icons.play_arrow,
              onPressed: () {
                if (state.status == TimerStatus.running) {
                  context.read<TimerCubit>().pauseTimer();
                } else {
                  context.read<TimerCubit>().startTimer();
                }
              },
              size: 120,
              backgroundColor: Colors.white,
              iconColor: const Color(0xFF2E7D9A),
            ),

            const SizedBox(width: 20),

            // Skip button
            _buildControlButton(
              icon: Icons.skip_next,
              onPressed: () => context.read<TimerCubit>().skipSession(),
              size: 60,
              backgroundColor: Colors.white.withOpacity(0.2),
            ),
          ],
        );
      },
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required double size,
    required Color backgroundColor,
    Color? iconColor,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        child: Icon(icon, size: size * 0.4, color: iconColor ?? Colors.white),
      ),
    );
  }
}
