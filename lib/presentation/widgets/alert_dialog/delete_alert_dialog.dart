import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/reminder/reminders/reminders_bloc.dart';
Future<dynamic> buildDeleteAlertDialog(BuildContext context, void Function() onPressed) {
  return showDialog(
    context: context,
    builder: (_) => BlocBuilder<RemindersBloc, RemindersState>(
      builder: (context, state) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.delete_button_inscription),
      content: Text(AppLocalizations.of(context)!.you_want_delete_inscription,
          style: Theme.of(context).textTheme.bodyMedium),
      actions: [
        TextButton(
          onPressed: () => context.router.pop(),
          child: Text(AppLocalizations.of(context)!.no_button_inscription),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(AppLocalizations.of(context)!.yes_button_inscription),
        )
      ],
    );
  },
),
  );
}