// models/app_state.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isTunisianDialect = false;

  AppState() {
    _loadPreferences();
  }

  bool get isDarkMode => _isDarkMode;
  bool get isTunisianDialect => _isTunisianDialect;

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _isTunisianDialect = prefs.getBool('isTunisianDialect') ?? false;
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  Future<void> toggleTunisianDialect() async {
    _isTunisianDialect = !_isTunisianDialect;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isTunisianDialect', _isTunisianDialect);
  }
}
