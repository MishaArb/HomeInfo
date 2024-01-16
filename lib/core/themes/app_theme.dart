import 'package:flutter/material.dart';
import 'package:home_info/core/themes/app_text_theme.dart';

import 'app_bar_theme.dart';
import 'app_colors.dart';


class AppTheme {
  static lightTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.whiteF8,
      appBarTheme: AppThemeAppBar.lightTheme(),
      textTheme: AppTextTheme.lightTextTheme(),
  );


  static darkTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.darkBlue22,
      appBarTheme: AppThemeAppBar.darkTheme(),
      textTheme: AppTextTheme.darkTextTheme(),
  );

}
