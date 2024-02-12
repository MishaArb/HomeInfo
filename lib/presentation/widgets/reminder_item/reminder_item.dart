import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';

import '../../../domain/entities/reminder_entity.dart';
import '../../bloc/theme/theme_bloc.dart';


buildReminderItem({
  required BuildContext context,
  required ReminderEntity reminderItem,
  required Function(BuildContext) onPressed,
}) {
  return SizedBox(
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final borderColor = state.currentTheme == ThemeMode.light
            ? AppColors.greyD9
            : AppColors.darkBlue2A;
        return Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.3,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: onPressed,
                backgroundColor: AppColors.red02,
                foregroundColor: AppColors.whiteFF,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!
                    .delete_button_inscription,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: borderColor),
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                reminderItem.title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        reminderItem.isRepeat ? Icons.repeat : Icons.alarm,
                        size: 20,
                        color: AppColors.grey82,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        DateFormat('dd-MM-yyyy').format(DateTime.parse(reminderItem.date)),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Text(
                    reminderItem.description,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
