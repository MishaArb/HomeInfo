import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppInputDecorationTheme {
  static lightTheme () =>
      InputDecorationTheme(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.red01),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.greyD9),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.blueE),
        ),
          hintStyle: const TextStyle(fontSize: 16, color: AppColors.grey82)
      );

   static darkTheme () =>
      InputDecorationTheme(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.red01),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:  BorderSide(color:  AppColors.grey82.withOpacity(0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.blueE),
        ),
        hintStyle: const TextStyle(fontSize: 16, color: AppColors.grey82)
      );
}