import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/asset_image.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../bloc/reminder/reminders/reminders_bloc.dart';
import '../../../widgets/alert_dialog/delete_alert_dialog.dart';
import '../../../widgets/app_bar/app_bar_with_arrow_back.dart';
import '../../../widgets/reminder_item/reminder_item.dart';
import 'new_reminder_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithArrowBack(
        title: AppLocalizations.of(context)!.reminders_app_bar_title,
        onPressedAction: () => context.router.back(),
      ),
      body: _buildReminderItemListView(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
}

_buildReminderItemListView() {
  return BlocBuilder<RemindersBloc, RemindersState>(
    builder: (context, state) {
      if (state is RemindersSuccessState) {
        return state.reminders.isEmpty
            ? const Center(
                child: Image(
                  width: 100,
                  height: 100,
                  image: AssetImage(AssetImagesConstant.emptyRemindersIcon),
                ),
              )
            : ListView.builder(
                itemCount: state.reminders.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildReminderItem(
                    context: context,
                    reminderItem: state.reminders[index],
                    onPressed: (cxt) => buildDeleteAlertDialog(
                      context,
                      () {
                        BlocProvider.of<RemindersBloc>(context).add(
                          RemindersDeleteEvent(
                            state.reminders[index].id,
                            context,
                          ),
                        );
                      },
                    ),
                  );
                },
              );
      } else {
        return const SizedBox();
      }
    },
  );
}

_buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      _showSelectIconBottomSheet(context);
    },
    backgroundColor: AppColors.blueE,
    child: const Icon(
      Icons.add,
      color: AppColors.whiteFF,
    ),
  );
}

_showSelectIconBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.black,
    barrierColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const NewReminderBottomSheet(),
      );
    },
  );
}


