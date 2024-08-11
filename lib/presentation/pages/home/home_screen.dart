import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:home_info/core/constants/chart.dart';
import 'package:home_info/presentation/bloc/reading/new_reading/new_reading_bloc.dart';
import '../../../core/constants/app_property.dart';
import '../../../core/constants/asset_image.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/enum/reading_enum.dart';
import '../../../injection_container.dart';
import '../../bloc/backup_restore_db/backup_restore_db_bloc.dart';
import '../../bloc/chart/chart_bloc.dart';
import '../../bloc/currency/currency_bloc.dart';
import '../../bloc/reading/readings/readings_bloc.dart';
import '../../bloc/reminder/reminders/reminders_bloc.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../widgets/alert_dialog/delete_alert_dialog.dart';
import '../../widgets/readings_item/readings_item.dart';
import '../../widgets/reminder_item/reminder_item.dart';
import '../../widgets/snack_bar/snack_bar.dart';

part 'chart.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartBloc>(
      create: (context) => getIt()..add(ChartInitEvent()),
      child:MultiBlocListener(
        listeners: [
          BlocListener<ReadingsBloc, ReadingsState>(
            listenWhen: (previous, current) => current is ReadingsSuccessState,
            listener: (context, state) {
              BlocProvider.of<ChartBloc>(context).add(ChartInitEvent());
            },
          ),
          BlocListener<BackupRestoreDbBloc, BackupRestoreDbState>(
            //  listenWhen: (previous, current) => current is RestoreDbSuccessState,
            listener: (context, state) {
              if(state is RestoreDbSuccessState){
                BlocProvider.of<ReadingsBloc>(context).add(ReadingsFetchEvent());
                BlocProvider.of<RemindersBloc>(context).add(RemindersFetchEvent());
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(state.successMessage, AppColors.blueE),
                );
              } else if(state is BackupDbSuccessState){
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(state.successMessage, AppColors.blueE),
                );
              } else if (state is RestoreDbErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(state.errorMessage, AppColors.red02),
                );
              } else if (state is BackupDbErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(state.errorMessage, AppColors.red02),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.app_name,
            ),
          ),
          body: Column(
            children: [
              const Chart(),
              _buildPeriodSwitcher(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .latest_readings_screen_title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    _buildLatestReadingsList(context),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!
                          .latest_reminders_screen_title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    _buildLatestReminders(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}

_buildPeriodSwitcher(BuildContext context) {
  return BlocBuilder<ChartBloc, ChartState>(
    builder: (context, state) {
      return SizedBox(
        width: 200,
        height: 40,
        child: CupertinoSlidingSegmentedControl<int>(
          padding: const EdgeInsets.all(5),
          thumbColor: AppColors.blueE,
          groupValue: state.chartPeriod == ChartPeriod.yearsPeriod ? 1 : 0,
          onValueChanged: (value) => {
            BlocProvider.of<ChartBloc>(context).add(
              ChartChangePeriodEvent(
                value == 0 ? ChartPeriod.monthsPeriod : ChartPeriod.yearsPeriod,
              ),
            )
          },
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
    },
  );
}

_buildLatestReadingsList(BuildContext context) {
  return Builder(
    builder: (context) {
     final  readingsState = context.select((ReadingsBloc bloc) => bloc.state);
     final  currencyState = context.select((CurrencyBloc bloc) => bloc.state);
      if (readingsState is ReadingsSuccessState) {
        return readingsState.readings.isEmpty
            ? const Padding(
          padding: EdgeInsets.all(20.0),
          child: Image(
            width: 100,
            height: 100,
            image: AssetImage(AssetImagesConstant.emptyReadingsIcon),
          ),
        )
            : Column(
          children: [
            for (var i = 0; i < readingsState.readings.length && i < 2; i++)
              buildReadingsItem(
                date: readingsState.readings[i].date,
                totalSum: double.parse(
                  readingsState.readings[i].totalSum.toStringAsFixed(2),
                ),
                percentDifference: i == readingsState.readings.length - 1
                    ? 0.0
                    : double.parse((((readingsState.readings[i].totalSum -
                    readingsState.readings[i + 1].totalSum) /
                    readingsState.readings[i + 1].totalSum) *
                    100)
                    .toStringAsFixed(2)),
                sumDifference: i == readingsState.readings.length - 1
                    ? 0
                    : double.parse(
                  (readingsState.readings[i].totalSum -
                      readingsState.readings[i + 1].totalSum)
                      .toStringAsFixed(2),
                ),
                onTap: () => BlocProvider.of<NewReadingBloc>(context).add(
                  NewReadingInitEvent(
                    context: context,
                    readingActionType: ReadingActionType.editReading,
                    readingIndex: i,
                  ),
                ),
                onDelete: (cxt) => buildDeleteAlertDialog(
                    context,
                        () {
                      BlocProvider.of<ReadingsBloc>(context).add(
                        ReadingsDeleteEvent(
                          id: readingsState.readings[i].id,
                          context: context,
                        ),
                      );
                    },
                  ),
                onShare: (ctx) {
                        BlocProvider.of<ReadingsBloc>(context).add(
                          ReadingsShareAllDataEvent(
                              context: ctx,
                            reading: readingsState.readings[i],
                              currency: currencyState.currency,
                          ),
                        );
                },

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

_buildLatestReminders(BuildContext context) {
  return BlocBuilder<RemindersBloc, RemindersState>(
    builder: (context, state) {
      if (state is RemindersSuccessState) {
        return state.reminders.isEmpty
            ? const Padding(
          padding: EdgeInsets.all(20.0),
          child: Image(
            width: 100,
            height: 100,
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
                      id: state.reminders[i].id,
                      notificationId: state.reminders[i].notificationId,
                      context: context,
                    ),
                  );
                },
                ),
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


