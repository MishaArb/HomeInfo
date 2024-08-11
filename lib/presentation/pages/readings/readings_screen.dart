import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:home_info/presentation/widgets/readings_item/readings_item.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_property.dart';
import '../../../core/constants/asset_image.dart';
import '../../../core/enum/reading_enum.dart';
import '../../bloc/currency/currency_bloc.dart';
import '../../bloc/reading/new_reading/new_reading_bloc.dart';
import '../../bloc/reading/readings/readings_bloc.dart';
import '../../widgets/alert_dialog/delete_alert_dialog.dart';


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
      body:
      Column(
        children: [
          // _buildSearchField(context),
          _buildReadingItemListView(),
        ],
      ),
    );
  }

  _buildSearchField(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pushNamed('/searchReadingScreen'),
      child: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(left: 10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: AppProperty.allBorderRadiusMediumSmall,
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

_buildReadingItemListView() {
  return Builder(
    builder: (context) {
      final  readingsState = context.select((ReadingsBloc bloc) => bloc.state);
      final  currencyState = context.select((CurrencyBloc bloc) => bloc.state);
      final locale = AppLocalizations.of(context)!;
      if (readingsState is ReadingsSuccessState) {
        return readingsState.readings.isEmpty
            ? const Expanded(
              child: Center(
                child: Image(
                  width: 100,
                  height: 100,
                  image: AssetImage(AssetImagesConstant.emptyReadingsIcon),
                ),
              ),
            )
            : Expanded(
                child: ListView.builder(
                  itemCount: readingsState.readings.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildReadingsItem(
                      date: readingsState.readings[index].date,
                      totalSum: double.parse(
                        readingsState.readings[index].totalSum.toStringAsFixed(2),
                      ),
                      percentDifference: index == readingsState.readings.length - 1
                          ? 0.0
                          : double.parse((((readingsState.readings[index].totalSum -
                          readingsState.readings[index + 1].totalSum) /
                          readingsState.readings[index + 1].totalSum) *
                                  100)
                              .toStringAsFixed(2)),
                      sumDifference: index == readingsState.readings.length - 1
                          ? 0
                          : double.parse(
                              (readingsState.readings[index].totalSum -
                                  readingsState.readings[index + 1].totalSum)
                                  .toStringAsFixed(2),
                            ),
                      onTap: () => BlocProvider.of<NewReadingBloc>(context).add(
                        NewReadingInitEvent(
                          context: context,
                          readingActionType: ReadingActionType.editReading,
                          readingIndex: index,
                        ),
                      ),
                      onDelete: (cxt) => buildDeleteAlertDialog(
                        context,
                            () {
                          BlocProvider.of<ReadingsBloc>(context).add(
                            ReadingsDeleteEvent(
                              id: readingsState.readings[index].id,
                              context: context,
                            ),
                          );
                        },
                      ),
                      onShare: (ctx) {
                        BlocProvider.of<ReadingsBloc>(context).add(
                          ReadingsShareAllDataEvent(
                            context: ctx,
                            reading:readingsState.readings[index],
                            currency: currencyState.currency,
                          ),
                        );
                      },
                    );
                  },
                ),
              );
      } else {
        return const SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
