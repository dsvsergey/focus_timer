import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';
import '../cubit/timer_cubit.dart';
import '../models/timer_state.dart';
import '../models/timer_session.dart';
import '../widgets/timer_display.dart';
import '../widgets/timer_controls.dart';
import '../widgets/cycle_progress.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: _getBackgroundColor(state.currentSessionType),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Session type title
                  Text(
                    context.read<TimerCubit>().getSessionTypeTitle(
                      AppLocalizations.of(context)!.focus,
                      AppLocalizations.of(context)!.shortBreak,
                      AppLocalizations.of(context)!.longBreak,
                    ),
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Timer display
                  const Expanded(flex: 3, child: TimerDisplay()),

                  const SizedBox(height: 40),

                  // Cycle progress
                  const CycleProgress(),

                  const SizedBox(height: 60),

                  // Timer controls
                  const TimerControls(),

                  const SizedBox(height: 40),

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
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
