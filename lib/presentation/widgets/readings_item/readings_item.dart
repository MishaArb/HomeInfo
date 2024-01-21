import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/themes/app_colors.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../pages/home/home_screen.dart';

SizedBox buildReadingsItem({
  required BuildContext context,
  required Readings readingsItem,
}) {
  return SizedBox(
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final borderColor = state.currentTheme == ThemeMode.light
            ? AppColors.greyD9
            : AppColors.darkBlue2A;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: borderColor),
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '${readingsItem.date.split('.').last}\n',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 8),
                children: <TextSpan>[
                  TextSpan(
                    text: '${readingsItem.date.split('.')[1]}\n',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text:
                    AppLocalizations.of(context)!.month_screen_inscription,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 8),
                  ),
                ],
              ),
            ),
            title: Text(
              '${AppLocalizations.of(context)!.total_sum_inscription}:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              '${readingsItem.total} грн',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const WidgetSpan(
                          child: Icon(
                            Icons.arrow_upward,
                            size: 18,
                            color: AppColors.green07,
                          )),
                      TextSpan(
                        text: '${readingsItem.percentDifference}%',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.green07),
                      ),
                    ],
                  ),
                ),
                Text(
                  '+${readingsItem.amountDifference} грн',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}