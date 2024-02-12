import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_colors.dart';
import '../../bloc/theme/theme_bloc.dart';

datePicker(BuildContext context) async {
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now().add(const Duration(days: 1)),
    firstDate: DateTime.now().add(const Duration(days: 1)),
    lastDate: DateTime(2110),
    builder: (context, child) {
      return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final colorScheme = state.currentTheme == ThemeMode.light
              ? const ColorScheme.light(
              onPrimary: AppColors.whiteFF,
              onSurface: AppColors.darkBlue2A,
              primary: AppColors.grey82)
              : const ColorScheme.dark(
              onPrimary: AppColors.blueE,
              onSurface: AppColors.whiteFF,
              primary: AppColors.darkBlue2A);

          final bgrColor = state.currentTheme == ThemeMode.light
              ? AppColors.greyD9
              : AppColors.darkBlue2A;
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: colorScheme,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.blueE,
                  backgroundColor: bgrColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            child: child!,
          );
        },
      );
    },
  );
}