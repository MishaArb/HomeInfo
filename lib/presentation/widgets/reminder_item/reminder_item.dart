
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_colors.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../pages/settings/reminder/reminders_screen.dart';

SizedBox buildReminderItem({
  required BuildContext context,
  required Reminder reminderItem,
}) {
  return SizedBox(
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final borderColor = state.currentTheme == ThemeMode.light
            ? AppColors.greyD9
            : AppColors.darkBlue2A;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: borderColor),
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              reminderItem.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              '${reminderItem.date}\n${reminderItem.description}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: reminderItem.isRepeat
                ? const Icon(
              Icons.event_repeat,
              size: 25,
              color: AppColors.grey82,
            )
                : null,
          ),
        );
      },
    ),
  );
}
