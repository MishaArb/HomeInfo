import 'package:flutter/material.dart';
import 'package:home_info/core/themes/app_text_theme.dart';

import 'app_bar_theme.dart';
import 'app_bottom_navigation_bar_theme.dart';
import 'app_check_box_theme.dart';
import 'app_colors.dart';
import 'app_input_decoration_theme.dart';

class AppTheme {
  static lightTheme() => ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.whiteF8,
        appBarTheme: AppThemeAppBar.lightTheme(),
        textTheme: AppTextTheme.lightTextTheme(),
        checkboxTheme: AppCheckBoxTheme.lightTheme(),
        inputDecorationTheme: AppInputDecorationTheme.lightTheme(),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: AppColors.black00),
        bottomNavigationBarTheme: AppBottomNavigationBarTheme.lightTheme(),
      );

  static darkTheme() => ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.darkBlue22,
        appBarTheme: AppThemeAppBar.darkTheme(),
        textTheme: AppTextTheme.darkTextTheme(),
        checkboxTheme: AppCheckBoxTheme.lightTheme(),
        inputDecorationTheme: AppInputDecorationTheme.darkTheme(),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: AppColors.whiteF8),
        bottomNavigationBarTheme: AppBottomNavigationBarTheme.darkTheme(),
      );
}
