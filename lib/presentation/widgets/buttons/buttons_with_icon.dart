import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/model/reading_model.dart';

Container buildButtonsWithIcon(
    {required ReadingItem reading,
    required IconData icon,
    required Color iconBgrColor,
    required void Function() onFunc}) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      color: iconBgrColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: IconButton(
      padding: EdgeInsets.zero,
      onPressed: () => onFunc(),
      icon: Icon(
        icon,
        color: AppColors.whiteF8,
      ),
    ),
  );
}
