// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'learn_screen.dart';
import 'challenge_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    LearnScreen(),
    ChallengeScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isDark = appState.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F1117) : const Color(0xFFF5F5F0),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: isDark ? const Color(0xFF1A1D27) : Colors.white,
        selectedItemColor: const Color(0xFF6C63FF),
        unselectedItemColor: isDark ? const Color(0xFF8888AA) : const Color(0xFF6B6B80),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'تعَلَّمْ'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events_rounded), label: 'تحدى روحك'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'الإعدادات'),
        ],
      ),
    );
  }
}
