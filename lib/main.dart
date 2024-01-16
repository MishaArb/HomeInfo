import 'package:flutter/material.dart';
import 'package:home_info/core/themes/app_theme.dart';
import 'package:home_info/presentation/pages/settings/reminder/reminders_screen.dart';
import 'package:home_info/presentation/pages/settings/settings_screen.dart';

void main() {
  runApp(const HomeInfoApp());
}

class HomeInfoApp extends StatelessWidget {
  const HomeInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeInfo',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home: SettingsScreen(),
    );
  }
}
