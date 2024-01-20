import 'package:flutter/material.dart';
import 'package:home_info/core/themes/app_colors.dart';
import '../../../widgets/elevated_button/elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewReminderBottomSheet extends StatelessWidget {
  const NewReminderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const NewReminderBottomSheetView();
  }
}

class NewReminderBottomSheetView extends StatelessWidget {
  const NewReminderBottomSheetView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: AppColors.whiteF8,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyE6,
            spreadRadius: 10,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTitle(
              context: context,
              title:  AppLocalizations.of(context)!.create_reminder_screen_title,
          ),
          _buildDatePicker(context),
          _buildReminderCheckBox(context),
          _buildReminderNameTextForm(context),
          _buildReminderDescriptionTextForm(context),
          buildElevationButton(
              buttonText: AppLocalizations.of(context)!.save_button_inscription,
              buttonAction: () {
                print('Зберегти');
              })
        ],
      ),
    );
  }
}

Text _buildTitle({required BuildContext context, required String title}) {
  return Text(title, style: Theme.of(context).textTheme.bodyLarge);
}

Row _buildDatePicker(BuildContext context) {
  return Row(
    children: [
      Text(AppLocalizations.of(context)!.pick_date_screen_inscription),
      const Spacer(),
      Text(
        '25.02.25',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.blueE,
            ),
      ),
    ],
  );
}

Row _buildReminderCheckBox(BuildContext context) {
  return Row(
    children: [
      Text((AppLocalizations.of(context)!.repeat_screen_inscription)),
      const Spacer(),
      Transform.scale(
        scale: 1.2,
        child: Checkbox(value: true, onChanged: (v) {}),
      )
    ],
  );
}

TextFormField _buildReminderNameTextForm(BuildContext context) {
  return TextFormField(
    keyboardType: TextInputType.text,
    maxLines: 1,
    controller: TextEditingController(),
    onChanged: (value) {},
    decoration: InputDecoration(
        hintText:AppLocalizations.of(context)!.title_hint_text,
    ),
  );
}

TextFormField _buildReminderDescriptionTextForm(BuildContext context) {
  return TextFormField(
    keyboardType: TextInputType.text,
    maxLines: 4,
    controller: TextEditingController(),
    onChanged: (value) {},
    decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.description_hint_text,
  ),
  );
}
