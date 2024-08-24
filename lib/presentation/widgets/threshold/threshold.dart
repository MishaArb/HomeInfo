import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_property.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/reading/new_reading/new_reading_bloc.dart';
Container buildThreshold(Color bgrColor, BuildContext context, bool threshold) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: AppProperty.allBorderRadiusMedium,
      color: bgrColor,
    ),
    margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    child: ListTile(
      title: Text(
        AppLocalizations.of(context)!.threshold_inscription,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Transform.scale(
        scale: 1.3,
        child: Checkbox(
          value: threshold,
          onChanged: (value) =>
              BlocProvider.of<NewReadingBloc>(context)
                  .add(NewReadingChangeThresholdEvent(value!),
              ),
        ),
      ),
    ),
  );
}