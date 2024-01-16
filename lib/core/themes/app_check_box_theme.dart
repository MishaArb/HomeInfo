import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppCheckBoxTheme {
  static lightTheme() => CheckboxThemeData(
        side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(width: 2.0, color: AppColors.blueE),
        ),
        shape: const CircleBorder(),
        visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.blueE;
            }
            return Colors.transparent;
          },
        ),
      );
}
