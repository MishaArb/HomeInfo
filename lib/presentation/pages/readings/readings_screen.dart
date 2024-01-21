import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:home_info/presentation/widgets/readings_item/readings_item.dart';

import '../../../core/themes/app_colors.dart';
import '../home/home_screen.dart';

@RoutePage()
class ReadingsScreen extends StatelessWidget {
  const ReadingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.readings_button_inscription,
        ),
      ),
      body: Column(
        children: [
          _buildSearchField(context),
          _buildReminderItemListView(),
        ],
      ),
    );
  }

  _buildSearchField(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(left: 10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border:
              Border.all(width: 1, color: AppColors.grey82.withOpacity(0.4)),
        ),
        child: Text(
          AppLocalizations.of(context)!.search_hint_text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.grey82.withOpacity(0.4)),
        ),
      ),
    );
  }
}

_buildReminderItemListView() {
  return Expanded(
    child: ListView.builder(
      itemCount: readingsList.length,
      itemBuilder: (BuildContext context, int index) {
        return buildReadingsItem(
            context: context, readingsItem: readingsList[index]);
      },
    ),
  );
}
