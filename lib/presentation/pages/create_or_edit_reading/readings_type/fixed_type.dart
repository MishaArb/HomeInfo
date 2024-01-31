import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../bloc/theme/theme_bloc.dart';
import '../../../widgets/buttons/share_and_delete_button.dart';
import '../../../widgets/text/result_inscription.dart';
import '../../../widgets/text_field/description_text_form.dart';
import '../../../widgets/text_field/simple_text_field.dart';

buildFixedType() {
  return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final bgrColor = state.currentTheme == ThemeMode.light
            ? AppColors.whiteFF
            : AppColors.darkBlue2A;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: bgrColor,
          ),
          child: Column(
            children: [
              buildSimpleTextForm(
                context: context,
                hintText: AppLocalizations.of(context)!.price_hint_text,
                onChanged: (value) {},
                controller: TextEditingController(),
              ),
              buildDescriptionTextForm(
                context: context,
                hintText: AppLocalizations.of(context)!.comment_unit_hint_text,
                controller: TextEditingController(),
              ),
              buildResultInscription(
                context: context,
                title: AppLocalizations.of(context)!.sum_inscription,
                result: '287,32 грн',
              ),
              buildShareAndDeleteButton(),
            ],
          ),
        );
      }
  );
}