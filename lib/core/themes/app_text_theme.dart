import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_font.dart';

class AppTextTheme {
  static lightTextTheme() => const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          color: AppColors.black00,
          fontFamily: AppFont.montserratBold700,
        ),
        titleMedium: TextStyle(
          fontSize: 12,
          fontFamily: AppFont.montserratMedium500,
          color: AppColors.black00,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontFamily: AppFont.montserratBold700,
          color: AppColors.black00,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontFamily: AppFont.montserratMedium500,
          color: AppColors.black00,
        ),
        bodySmall: TextStyle(
          fontSize: 10,
          fontFamily: AppFont.montserratMedium500,
          color: AppColors.black00,
        ),
      );

  static darkTextTheme() => const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          color: AppColors.whiteFF,
          fontFamily: AppFont.montserratBold700,
        ),
        titleMedium: TextStyle(
          fontSize: 12,
          fontFamily: AppFont.montserratMedium500,
          color: AppColors.greyD9,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          fontFamily: AppFont.montserratBold700,
          color: AppColors.whiteFF,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontFamily: AppFont.montserratMedium500,
          color: AppColors.whiteFF,
        ),
        bodySmall: TextStyle(
          fontSize: 10,
          fontFamily: AppFont.montserratMedium500,
          color: AppColors.whiteFF,
        ),
      );
}
