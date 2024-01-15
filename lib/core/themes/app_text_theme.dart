import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_font.dart';

class AppTextTheme {
  static lightTextTheme() => const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          color: AppColors.black00,
          fontFamily: AppFont.montserratBold700,
        ),
      );

  static darkTextTheme() => const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          color: AppColors.whiteFF,
          fontFamily: AppFont.montserratBold700,
        ),
      );
}