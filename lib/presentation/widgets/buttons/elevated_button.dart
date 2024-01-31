import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_font.dart';

Row buildElevationButton({
  required String buttonText,
  required Function() buttonAction
}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 1,
              backgroundColor: AppColors.blueE,
              foregroundColor: AppColors.blueF6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // <-- Radius
              ),
            ),
            onPressed: buttonAction,
            child: Text(
              buttonText,
              style: const TextStyle(
                color: AppColors.whiteF8,
                fontSize: 18,
                fontFamily: AppFont.montserratBold700,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
