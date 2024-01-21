import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppBottomNavigationBarTheme {
  static lightTheme() => const BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteF8,
      selectedItemColor: AppColors.blueE,
      unselectedItemColor: AppColors.grey82);

  static darkTheme() => const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBlue22,
      selectedItemColor: AppColors.blueE,
      unselectedItemColor: AppColors.grey82);
}
