import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/timer_cubit.dart';
import '../models/timer_state.dart';

class CycleProgress extends StatelessWidget {
  const CycleProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              'Pomodoro Cycle',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildProgressDot(
                    isCompleted: index < state.currentCycleStep,
                    isCurrent: index == state.currentCycleStep,
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgressDot({
    required bool isCompleted,
    required bool isCurrent,
  }) {
    Color dotColor;
    double size;
    Widget? child;

    if (isCompleted) {
      dotColor = Colors.white;
      size = 12;
      child = const Icon(Icons.check, size: 8, color: Color(0xFF2E7D9A));
    } else if (isCurrent) {
      dotColor = Colors.white.withOpacity(0.5);
      size = 16;
    } else {
      dotColor = Colors.white.withOpacity(0.2);
      size = 12;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dotColor,
        border: isCurrent ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: child,
    );
  }
}
