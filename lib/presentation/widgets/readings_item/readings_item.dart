import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../bloc/currency/currency_bloc.dart';
import '../../bloc/theme/theme_bloc.dart';

SizedBox buildReadingsItem({
  required String date,
  required double totalSum,
  required double percentDifference,
  required double sumDifference,
  required void Function() onTap,
  required Function(BuildContext) onDelete,
  required Function(BuildContext) onShare,
}) {
  return SizedBox(
    child: Builder(
      builder: (context) {
        final themeState = context.select((ThemeBloc bloc) => bloc.state);
        final currencyState = context.select((CurrencyBloc bloc) => bloc.state);
        final borderColor = themeState.currentTheme == ThemeMode.light
            ? AppColors.greyD9
            : AppColors.darkBlue2A;
        return Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.6,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: onDelete,
                backgroundColor: AppColors.red02,
                foregroundColor: AppColors.whiteFF,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!
                    .delete_button_inscription,
              ),
              SlidableAction(
                onPressed:  onShare,
                backgroundColor: AppColors.blueD7,
                foregroundColor: AppColors.whiteFF,
                icon: Icons.share,
                label: AppLocalizations.of(context)!
                    .share_button_inscription,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: borderColor),
              ),
            ),
            child: ListTile(
              onTap: () => onTap(),
              contentPadding: EdgeInsets.zero,
              leading: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '${DateFormat('yyyy').format(DateTime.parse(date))}\n',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 8),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${DateFormat('MM').format(DateTime.parse(date))}\n',
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
                '$totalSum ${currencyState.currency}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: percentDifference > 0
                              ? const Icon(
                                  Icons.arrow_upward,
                                  size: 18,
                                  color: AppColors.green07,
                                )
                              : percentDifference == 0
                                  ? const SizedBox()
                                  : const Icon(
                                      Icons.arrow_downward,
                                      size: 18,
                                      color: AppColors.red02,
                                    ),
                        ),
                        TextSpan(
                          text: '$percentDifference %',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: percentDifference > 0
                                  ? AppColors.green07
                                  : percentDifference == 0
                                      ? null
                                      : AppColors.red02),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${sumDifference > 0 ? '+' : sumDifference == 0 ? '' : ''}$sumDifference ${currencyState.currency}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
