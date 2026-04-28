import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'models/app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const RafiqBarmajaApp(),
    ),
  );
}

class RafiqBarmajaApp extends StatelessWidget {
  const RafiqBarmajaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return MaterialApp(
          title: 'رفيق البرمجة',
          debugShowCheckedModeBanner: false,
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFF2563EB),
            scaffoldBackgroundColor: const Color(0xFFF8FAFC),
            fontFamily: GoogleFonts.cairo().fontFamily,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF2563EB),
              foregroundColor: Colors.white,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xFF3B82F6),
            scaffoldBackgroundColor: const Color(0xFF0F172A),
            fontFamily: GoogleFonts.cairo().fontFamily,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1E293B),
              foregroundColor: Colors.white,
            ),
          ),
          locale: const Locale('ar'),
          supportedLocales: const [Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const HomeScreen(),
        );
      },
    );
  }
}
