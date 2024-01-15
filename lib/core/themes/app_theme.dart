import 'package:flutter/material.dart';
import 'package:home_info/core/themes/app_text_theme.dart';

class AppTheme {
  static lightTheme() => ThemeData(
        useMaterial3: true,
        textTheme: AppTextTheme.lightTextTheme(),
      );

  static darkTheme() => ThemeData(
        useMaterial3: true,
        textTheme: AppTextTheme.darkTextTheme(),
      );
}
