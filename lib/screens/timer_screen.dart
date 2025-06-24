import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../l10n/app_localizations.dart';
import '../cubit/timer_cubit.dart';
import '../models/timer_state.dart';
import '../models/timer_session.dart';
import '../widgets/timer_display.dart';
import '../widgets/timer_controls.dart';
import '../widgets/cycle_progress.dart';
import '../widgets/custom_title_bar.dart';
import '../widgets/animated_window_container.dart';
import '../core/injection.dart';
import '../services/window_service.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final windowService = getIt<WindowService>();

    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: _getBackgroundColor(state.currentSessionType),
          body: AnimatedWindowContainer(
            isVisible: windowService.isWindowVisible,
            duration: const Duration(milliseconds: 250),
            child: Column(
              children: [
                // Custom title bar for desktop platforms
                if (Platform.isWindows || Platform.isMacOS || Platform.isLinux)
                  CustomTitleBar(
                    title: 'Focus Timer',
                    backgroundColor: _getBackgroundColor(
                      state.currentSessionType,
                    ),
                  ),

                // Main content
                Expanded(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),

                            // Session type title
                            Text(
                              context.read<TimerCubit>().getSessionTypeTitle(
                                AppLocalizations.of(context)!.focus,
                                AppLocalizations.of(context)!.shortBreak,
                                AppLocalizations.of(context)!.longBreak,
                              ),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Timer display
                            const TimerDisplay(),

                            const SizedBox(height: 30),

                            // Cycle progress
                            const CycleProgress(),

                            const SizedBox(height: 40),

                            // Timer controls
                            const TimerControls(),

                            const SizedBox(height: 30),

                            // Session stats
                            _buildSessionStats(
                              state,
                              AppLocalizations.of(context)!.today,
                              AppLocalizations.of(context)!.cycles,
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getBackgroundColor(SessionType sessionType) {
    return switch (sessionType) {
      SessionType.focus => const Color(0xFF2E7D9A), // Deep blue for focus
      SessionType.shortBreak => const Color(
        0xFF4CAF50,
      ), // Green for short break
      SessionType.longBreak => const Color(0xFF9C27B0), // Purple for long break
    };
  }

  Widget _buildSessionStats(
    TimerState state,
    String todayLabel,
    String cyclesLabel,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            todayLabel,
            '${state.totalFocusSessions}',
            Icons.today,
          ),
          Container(width: 1, height: 30, color: Colors.white.withOpacity(0.3)),
          _buildStatItem(
            cyclesLabel,
            '${state.completedCycles}',
            Icons.refresh,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Inter',
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
