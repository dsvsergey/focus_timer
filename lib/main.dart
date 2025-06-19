import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cubit/timer_cubit.dart';
import 'repositories/database_repository.dart';
import 'screens/timer_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FocusTimerApp());
}

class FocusTimerApp extends StatelessWidget {
  const FocusTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D9A),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => TimerCubit(DatabaseRepository())..initialize(),
        child: const TimerScreen(),
      ),
    );
  }
}
