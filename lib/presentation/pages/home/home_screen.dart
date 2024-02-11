import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/constants/asset_image.dart';
import '../../../core/themes/app_colors.dart';
import '../../bloc/reminder/reminders/reminders_bloc.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../widgets/alert_dialog/delete_alert_dialog.dart';
import '../../widgets/readings_item/readings_item.dart';
import '../../widgets/reminder_item/reminder_item.dart';


class Readings {
  Readings(
      this.date, this.total, this.percentDifference, this.amountDifference);

  final String date;
  final String total;
  final String percentDifference;
  final String amountDifference;
}

List<Readings> readingsList = [
  Readings(
    '25.08.2024',
    '4220.30',
    '4.2',
    '125',
  ),
  Readings('25.09.2024', '3358', '1.2', '50'),
  Readings('25.10.2024', '3387.75', '2.20', '75.30'),
  Readings('25.11.2024', '4852.25', '4.75', '178.40'),
  Readings('25.12.2024', '5762.25', '2.7', '44.35'),
];

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.app_name,
              ),
            ),
            body: Column(
              children: [
                _buildChart(),
                _buildPeriodSwitcher(context),
                _buildReadingsAndRemindersList(context)
              ],
            ),
          );
  }
}

Expanded _buildChart() {
  return Expanded(
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final bgrColor = state.currentTheme == ThemeMode.light
            ? AppColors.whiteFF
            : AppColors.darkBlue2A;
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            color: bgrColor,
          ),
        );
      },
    ),
  );
}

SizedBox _buildPeriodSwitcher(BuildContext context) {
  return SizedBox(
    width: 200,
    height: 40,
    child: CupertinoSlidingSegmentedControl<int>(
      padding: const EdgeInsets.all(5),
      thumbColor: AppColors.blueE,
      groupValue: 0,
      onValueChanged: (value) => {},
      children: {
        0: Text(
          AppLocalizations.of(context)!.months_button_inscription,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        1: Text(
          AppLocalizations.of(context)!.years_button_inscription,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      },
    ),
  );
}

_buildReadingsAndRemindersList(BuildContext context) {
  return  Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(
                AppLocalizations.of(context)!.latest_readings_screen_title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              buildReadingsItem(
                context: context,
                readingsItem: readingsList[0],
              ),
              buildReadingsItem(
                context: context,
                readingsItem: readingsList[1],
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.latest_reminders_screen_title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              _buildLatestReminders(context)
            ],
          ),
        ),
      );
}

_buildLatestReminders(BuildContext context) {
  return BlocBuilder<RemindersBloc, RemindersState>(
    builder: (context, state) {
      if (state is RemindersSuccessState) {
        return state.reminders.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image(
                  width: 70,
                  height: 80,
                  image: AssetImage(AssetImagesConstant.emptyRemindersIcon),
                ),
              )
            : Column(
                children: [
                  for (var i = 0; i < state.reminders.length && i < 2; i++)
                    buildReminderItem(
                      context: context,
                      reminderItem: state.reminders[i],
                      onPressed: (cxt) => buildDeleteAlertDialog(context, () {
                        BlocProvider.of<RemindersBloc>(context).add(
                          RemindersDeleteEvent(
                            state.reminders[i].id,
                            context,
                          ),
                        );
                      }),
                    ),
                ],
              );
      } else {
        return const SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
