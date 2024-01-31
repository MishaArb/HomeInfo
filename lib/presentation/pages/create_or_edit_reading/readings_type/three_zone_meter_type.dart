import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../bloc/theme/theme_bloc.dart';
import '../../../widgets/buttons/share_and_delete_button.dart';
import '../../../widgets/text/result_inscription.dart';
import '../../../widgets/text_field/description_text_form.dart';
import '../../../widgets/text_field/simple_text_field.dart';

buildThreeZoneMeterType() {
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context)!.day_inscription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    AppLocalizations.of(context)!.half_peak_inscription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    AppLocalizations.of(context)!.night_inscription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: buildSimpleTextForm(
                      context: context,
                      hintText:
                      AppLocalizations.of(context)!.previous_readings_unit_hint_text,
                      onChanged: (value) {},
                      controller: TextEditingController(),
                    ),
                  ),
                  Expanded(
                    child: buildSimpleTextForm(
                      context: context,
                      hintText:
                      AppLocalizations.of(context)!.previous_readings_unit_hint_text,
                      onChanged: (value) {},
                      controller: TextEditingController(),
                    ),
                  ),
                  Expanded(
                    child: buildSimpleTextForm(
                      context: context,
                      hintText:
                      AppLocalizations.of(context)!.previous_readings_unit_hint_text,
                      onChanged: (value) {},
                      controller: TextEditingController(),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: buildSimpleTextForm(
                      context: context,
                      hintText:
                      AppLocalizations.of(context)!.current_readings_unit_hint_text,
                      onChanged: (value) {},
                      controller: TextEditingController(),
                    ),
                  ),
                  Expanded(
                    child: buildSimpleTextForm(
                      context: context,
                      hintText:
                      AppLocalizations.of(context)!.current_readings_unit_hint_text,
                      onChanged: (value) {},
                      controller: TextEditingController(),
                    ),
                  ),
                  Expanded(
                    child: buildSimpleTextForm(
                      context: context,
                      hintText:
                      AppLocalizations.of(context)!.current_readings_unit_hint_text,
                      onChanged: (value) {},
                      controller: TextEditingController(),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: buildSimpleTextForm(
                      context: context,
                      hintText:
                      AppLocalizations.of(context)!.zonal_coefficient_hint_text,
                      onChanged: (value) {},
                      controller: TextEditingController(),
                    ),
                  ),
                  Expanded(
                    child: buildSimpleTextForm(
                      context: context,
                      hintText:
                      AppLocalizations.of(context)!.zonal_coefficient_hint_text,
                      onChanged: (value) {},
                      controller: TextEditingController(),
                    ),
                  ),
                  Expanded(
                    child: buildSimpleTextForm(
                      context: context,
                      hintText:
                      AppLocalizations.of(context)!.zonal_coefficient_hint_text,
                      onChanged: (value) {},
                      controller: TextEditingController(),
                    ),
                  )
                ],
              ),
              buildSimpleTextForm(
                context: context,
                hintText: AppLocalizations.of(context)!.price_per_unit_hint_text,
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
                title: AppLocalizations.of(context)!.used_day_inscription,
                result: '58,32 кВт',
              ),
              buildResultInscription(
                context: context,
                title: AppLocalizations.of(context)!.used_night_inscription,
                result: '78,32 кВт',
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