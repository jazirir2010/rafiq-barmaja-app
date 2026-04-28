// screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isDark = appState.isDarkMode;

    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('الوضع الليلي'),
            subtitle: Text(isDark ? 'مفعل' : 'غير مفعل'),
            value: isDark,
            onChanged: (_) => appState.toggleDarkMode(),
          ),
          SwitchListTile(
            title: const Text('البرمجة بالدارجة التونسية'),
            subtitle: Text(appState.isTunisianDialect ? 'مفعل' : 'غير مفعل'),
            value: appState.isTunisianDialect,
            onChanged: (_) => appState.toggleTunisianDialect(),
          ),
        ],
      ),
    );
  }
}
