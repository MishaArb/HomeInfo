import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_info/core/constants/app_colors.dart';
import 'package:home_info/injection_container.dart';
import 'package:home_info/presentation/bloc/reminder/reminders/reminders_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_property.dart';
import '../../../bloc/reminder/new_reminder/new_reminder_bloc.dart';
import '../../../bloc/theme/theme_bloc.dart';
import '../../../widgets/buttons/elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewReminderBottomSheet extends StatelessWidget {
  const NewReminderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const NewReminderBottomSheetView();
  }
}

class NewReminderBottomSheetView extends StatefulWidget {
  const NewReminderBottomSheetView({
    super.key,
  });

  @override
  State<NewReminderBottomSheetView> createState() =>
      _NewReminderBottomSheetViewState();
}

class _NewReminderBottomSheetViewState
    extends State<NewReminderBottomSheetView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final textFieldKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewReminderBloc>(
      create: (context) => getIt<NewReminderBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final bgrColor = state.currentTheme == ThemeMode.light
              ? AppColors.whiteFF
              : AppColors.darkBlue2A;
          final shadow = state.currentTheme == ThemeMode.light
              ? AppColors.greyD9
              : AppColors.black00.withOpacity(0.2);

          return Form(
            key: textFieldKey,
            child: Container(
              height: 450,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: bgrColor,
                borderRadius: AppProperty.topRightTopLeftBorderRadiusMedium,
                boxShadow: [
                  BoxShadow(
                    color: shadow,
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTitle(
                    AppLocalizations.of(context)!.create_reminder_screen_title,
                  ),
                  _buildDatePicker(),
                  _buildRepeatCheckBox(),
                  _buildReminderTitleTextForm(),
                  _buildReminderDescriptionTextForm(),
                  _buildSaveButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildTitle(String title) {
    return Text(title, style: Theme.of(context).textTheme.bodyLarge);
  }

  _buildDatePicker() {
    return BlocBuilder<NewReminderBloc, NewReminderState>(
      builder: (context, state) {
        return Row(
          children: [
            Text(AppLocalizations.of(context)!.pick_date_screen_inscription),
            const Spacer(),
            TextButton(
              onPressed: () => BlocProvider.of<NewReminderBloc>(context).add(
                NewReminderPickDateEvent(context),
              ),
              child: Text(
                DateFormat('dd-MM-yyyy').format(DateTime.parse(state.date)),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.blueE,
                    ),
              ),
            )
          ],
        );
      },
    );
  }

  _buildRepeatCheckBox() {
    return BlocBuilder<NewReminderBloc, NewReminderState>(
      builder: (context, state) {
        return Row(
          children: [
            Text((AppLocalizations.of(context)!.repeat_screen_inscription)),
            const Spacer(),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                  value: state.isRepeat,
                  onChanged: (value) =>
                      BlocProvider.of<NewReminderBloc>(context)
                          .add(NewReminderRepeatEvent(value!))),
            )
          ],
        );
      },
    );
  }

  _buildReminderTitleTextForm() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      maxLines: 1,
      controller: _titleController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return AppLocalizations.of(context)!.field_cant_be_empty_error_text;
        } else {
          return null;
        }
      },
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.title_hint_text,
      ),
    );
  }

  _buildReminderDescriptionTextForm() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      maxLines: 4,
      controller: _descriptionController,
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.description_hint_text,
      ),
    );
  }

  _buildSaveButton() {
    return BlocBuilder<NewReminderBloc, NewReminderState>(
      builder: (context, state) {
        return buildElevationButton(
          buttonText: AppLocalizations.of(context)!.save_button_inscription,
          buttonAction: () {
            if (textFieldKey.currentState!.validate()) {
              BlocProvider.of<NewReminderBloc>(context).add(
                  NewReminderSaveEvent(
                      cxt: context,
                      title: _titleController.text,
                      description: _descriptionController.text));
              BlocProvider.of<RemindersBloc>(context)
                  .add(RemindersFetchEvent());
            }
          },
        );
      },
    );
  }
}
