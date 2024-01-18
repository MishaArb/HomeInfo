import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../widgets/app_bar/app_bar_with_arrow_back.dart';
import 'new_reminder_bottom_sheet.dart';

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
        title: 'Нагадування',
        onPressedAction: () => context.router.back(),
      ),
      body: const RemindersScreenView(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
}

class RemindersScreenView extends StatelessWidget {
  const RemindersScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildReminderItemListView();
  }
}

ListView _buildReminderItemListView() {
  return ListView.builder(
    itemCount: reminderList.length,
    itemBuilder: (BuildContext context, int index) {
      return _buildReminderItem(
        context: context,
        reminderItem: reminderList[index],
      );
    },
  );
}

Container _buildReminderItem({
  required BuildContext context,
  required Reminder reminderItem,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 1, color: AppColors.greyE6),
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
            : null),
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
