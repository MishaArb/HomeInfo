import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../bloc/theme/theme_bloc.dart';
import '../../../widgets/app_bar/app_bar_with_arrow_back.dart';
import '../../../widgets/reminder_item/reminder_item.dart';
import 'new_reminder_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Reminder {
  Reminder(this.name, this.date, this.description, this.isRepeat);

  final String name;
  final String description;
  final String date;
  final bool isRepeat;
}

List<Reminder> reminderList = [
  Reminder(
    'Rent',
    '25.02.2022',
    'You have to pay the rent',
    true,
  ),
  Reminder('Internet', '15.02.2022', 'You need to pay for the Internet', false),
  Reminder('Water', '10.02.2022', 'You have to pay for water', true)
];

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
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return _buildReminderItemListView();
        },
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
}

ListView _buildReminderItemListView() {
  return ListView.builder(
    itemCount: reminderList.length,
    itemBuilder: (BuildContext context, int index) {
      return buildReminderItem(
        context: context,
        reminderItem: reminderList[index],
      );
    },
  );
}

FloatingActionButton _buildFloatingActionButton(BuildContext context) {
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
