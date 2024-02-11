import 'package:flutter/material.dart';

import 'app_colors.dart';

class ColorSchemeTheme{
  static lightColorScheme () => const ColorScheme.light(
    primary: AppColors.whiteFF,
    onPrimary: AppColors.blueE,
    onSurface: AppColors.black00,
  );

  static darkColorScheme () => const ColorScheme.dark(
    primary: AppColors.darkBlue2A,
    onPrimary: AppColors.blueE,
    onSurface: AppColors.whiteFF,
  );
}