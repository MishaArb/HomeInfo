import 'package:flutter/material.dart';
import 'package:home_info/core/themes/app_theme.dart';
import 'package:home_info/presentation/pages/settings/language/language_screen.dart';
import 'package:home_info/presentation/pages/settings/reminder/reminders_screen.dart';
import 'package:home_info/presentation/pages/settings/settings_screen.dart';
import 'package:home_info/presentation/pages/settings/theme/theme_screen.dart';

import 'core/router/router.dart';
import 'injection_container.dart';

Future<void> main()async {

  await setupGetIt();
  runApp(const HomeInfoApp());
}

class HomeInfoApp extends StatelessWidget {
  const HomeInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'HomeInfo',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      routerConfig: getIt<AppRouter>().config(),
    );
  }
}
