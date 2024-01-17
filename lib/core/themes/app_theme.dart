import 'package:flutter/material.dart';
import 'package:home_info/core/themes/app_text_theme.dart';

import 'app_bar_theme.dart';
import 'app_check_box_theme.dart';
import 'app_colors.dart';
import 'app_input_decoration_theme.dart';

class AppTheme {
  static lightTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.whiteF8,
      appBarTheme: AppThemeAppBar.lightTheme(),
      textTheme: AppTextTheme.lightTextTheme(),
      checkboxTheme: AppCheckBoxTheme.lightTheme(),
      inputDecorationTheme: AppInputDecorationTheme.lightTheme(),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.black00),
  );

  static darkTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.darkBlue22,
      appBarTheme: AppThemeAppBar.darkTheme(),
      textTheme: AppTextTheme.darkTextTheme(),
      checkboxTheme: AppCheckBoxTheme.lightTheme(),
      inputDecorationTheme: AppInputDecorationTheme.darkTheme(),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.whiteF8),
  );
}
