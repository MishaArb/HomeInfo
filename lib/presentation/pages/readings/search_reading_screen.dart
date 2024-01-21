import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/themes/app_colors.dart';

@RoutePage()
class SearchReadingScreen extends StatelessWidget {
  const SearchReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          _buildReminderNameTextForm(context),
        ],
      ),
    );
  }
}

_buildReminderNameTextForm(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: TextFormField(
      keyboardType: TextInputType.number,
      maxLines: 1,
      controller: TextEditingController(),
      onChanged: (value) {},
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.blueE),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.grey82.withOpacity(0.4)),
        ),
        hintText: AppLocalizations.of(context)!.search_for_example_hint_text,
      ),
    ),
  );
}
