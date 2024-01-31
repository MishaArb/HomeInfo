import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';

buildShareAndDeleteButton() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              width: 1,
              color: AppColors.blueF6,
            ),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: AppColors.blueF6,
            ),
          ),
        ),
        Container(
          // alignment: Alignment.center,
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              width: 1,
              color: AppColors.red02,
            ),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(
              Icons.delete_forever,
              color: AppColors.red02,
            ),
          ),
        ),
      ],
    ),
  );
}