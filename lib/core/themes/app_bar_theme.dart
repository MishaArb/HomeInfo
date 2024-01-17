import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_font.dart';

class AppThemeAppBar {
  static lightTheme() => const AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.whiteF8,
        scrolledUnderElevation: 0,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: AppFont.montserratBold700,
          fontSize: 28,
          color: AppColors.black00,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.whiteF8,
          systemNavigationBarColor: AppColors.whiteF8,
          statusBarIconBrightness: Brightness.dark,
        ),
       iconTheme: IconThemeData(color: AppColors.black00),
      );

  static darkTheme() => const AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.darkBlue22,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: AppFont.montserratBold700,
          fontSize: 28,
          color: AppColors.whiteFF,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.darkBlue22,
          systemNavigationBarColor: AppColors.darkBlue22,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: AppColors.whiteFE),
      );
}
