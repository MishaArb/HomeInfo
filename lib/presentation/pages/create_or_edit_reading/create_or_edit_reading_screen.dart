import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:home_info/presentation/bloc/reading/new_reading/new_reading_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_property.dart';
import '../../../core/constants/asset_image.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/reading.dart';
import '../../../core/enum/reading_enum.dart';
import '../../../core/router/router.dart';
import '../../../data/model/reading_model.dart';
import '../../bloc/reading/readings/readings_bloc.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../widgets/buttons/buttons_with_icon.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/text/result_inscription.dart';
import '../../widgets/text_field/description_text_form.dart';
import '../../widgets/text_field/simple_text_field.dart';
import 'package:share_plus/share_plus.dart';
part 'readings_type/single_zone_meter_type.dart';

part 'readings_type/fixed_type.dart';

part 'readings_type/area_type.dart';

part 'readings_type/three_zone_meter_type.dart';

part 'readings_type/two_zone_meter_type.dart';

final textFieldKey = GlobalKey<FormState>();

@RoutePage()
class CreateOrEditReadingsScreen extends StatelessWidget {
  const CreateOrEditReadingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildContentScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildSaveButton(context),
    );
  }
}

_buildAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(70),
    child: BlocListener<NewReadingBloc, NewReadingCreateState>(
      listenWhen: (previous, current) => current is NewReadingSuccessState,
      listener: (context, state) {
        BlocProvider.of<ReadingsBloc>(context).add(ReadingsFetchEvent());
      },
      child: Builder(
        builder: (context) {
          final readingState =
              context.select((NewReadingBloc bloc) => bloc.state);
          final themeState = context.select((ThemeBloc bloc) => bloc.state);
          final bgrColor = themeState.currentTheme == ThemeMode.light
              ? AppColors.whiteFF
              : AppColors.darkBlue2A;
          final textColor = themeState.currentTheme == ThemeMode.light
              ? AppColors.darkBlue2A
              : AppColors.whiteFF;
          final date = DateFormat('dd-MM-yy').format(
            DateTime.parse(readingState.date),
          );
          final title =
              readingState.readingActionType == ReadingActionType.editReading
                  ? AppLocalizations.of(context)!.edit_record_app_bar_title
                  : AppLocalizations.of(context)!.new_record_app_bar_title;
          return Column(
            children: [
              AppBar(
                leading: IconButton(
                  onPressed: () => context.router.pop(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: textColor,
                  ),
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  systemNavigationBarColor: bgrColor,
                ),
                centerTitle: true,
                title: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 20,
                        color: textColor,
                      ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => BlocProvider.of<NewReadingBloc>(context)
                        .add(NewReadingPickDateEvent(context)),
                    child: Text(
                      date,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.blueE,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    ),
  );
}

_buildContentScreen() {
  return BlocBuilder<NewReadingBloc, NewReadingCreateState>(
    builder: (context, state) {
      final items = state.readingItems;
      return Column(
        children: [
          _buildServicesList(),
          items.isEmpty
              ? const SizedBox()
              : _buildTypeAndUnitPicker(),
          items.isNotEmpty
              ? Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                items[state.indexService].typeMeasure == ReadingTypeMeasure.undetectableType
                    ? const SizedBox()
                    : items[state.indexService].typeMeasure == ReadingTypeMeasure.areaType
                    ? AreaType(reading: items[state.indexService])
                    : items[state.indexService].typeMeasure == ReadingTypeMeasure.fixedType
                    ? FixedType(reading: items[state.indexService])
                    : items[state.indexService].typeMeasure ==ReadingTypeMeasure.singleZoneMeterType
                    ? SingleZoneMeterType(reading: items[state.indexService])
                    : items[state.indexService].typeMeasure == ReadingTypeMeasure.twoZoneMeterType
                    ? TwoZoneMeterType(reading: items[state.indexService])
                    : items[state.indexService].typeMeasure == ReadingTypeMeasure.threeZoneMeterType
                    ? ThreeZoneMeterType(reading: state.readingItems[state.indexService])
                    : const SizedBox(),
                const SizedBox(height: 100)
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      );
    },
  );
}

_buildServicesList() {
  return BlocBuilder<NewReadingBloc, NewReadingCreateState>(
    builder: (context, state) {
      return SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.readingItems.length + 1,
          itemBuilder: (context, index) {
            final serviceIndex = index - 1;
            if (index == 0) {
              return _buildServiceItem(
                onTapAction: () {
                  if (state.readingItems.isNotEmpty) {
                    if (textFieldKey.currentState == null) {
                      print("formKey.currentState is null!");
                    } else if (textFieldKey.currentState!.validate()) {
                      context.router.push(
                        ServicesRoute(blocContext: context),
                      );
                    }
                  } else {
                    context.router.push(
                      ServicesRoute(blocContext: context),
                    );
                  }
                },
              );
            } else {
              return _buildServiceItem(
                service: state.readingItems[serviceIndex],
                index: serviceIndex,
                onTapAction: () {
                  if (textFieldKey.currentState == null) {
                    print("formKey.currentState is null!");
                  } else if (textFieldKey.currentState!.validate()) {
                    BlocProvider.of<NewReadingBloc>(context).add(
                      NewReadingChangeServiceEvent(serviceIndex),
                    );
                  }
                },
              );
            }
          },
        ),
      );
    },
  );
}

_buildServiceItem(
    {int? index, ReadingItem? service, required Function() onTapAction}) {
  return Builder(
    builder: (context) {
      final readingState = context.select((NewReadingBloc bloc) => bloc.state);
      final themeState = context.select((ThemeBloc bloc) => bloc.state);
      final bgrColor = themeState.currentTheme == ThemeMode.light
          ? AppColors.whiteFF
          : AppColors.darkBlue2A;
      return GestureDetector(
        onTap: () => onTapAction(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: AppProperty.allBorderRadiusMediumSmall,
            color: bgrColor,
            border: readingState.indexService == index
                ? Border.all(width: 2, color: AppColors.blueE)
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: index == null
                      ? AppColors.blueE
                      : AppColors.servicesColors[service!.iconColor],
                  borderRadius: AppProperty.allBorderRadiusExtraLarge,
                ),
                child: index == null
                    ? const Icon(
                        Icons.add_circle_outline,
                        color: AppColors.whiteFF,
                      )
                    : Image(
                        image: AssetImage(
                          AssetImagesConstant.servicesImg[service!.icon],
                        ),
                      ),
              ),
              const SizedBox(width: 10),
              Text(
                index == null
                    ? AppLocalizations.of(context)!
                        .add_service_button_inscription
                    : service!.title,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      );
    },
  );
}

_buildTypeAndUnitPicker() {
  return Align(
    alignment: const Alignment(0, 0.8),
    child: Builder(
      builder: (context) {
        final readingState =
            context.select((NewReadingBloc bloc) => bloc.state);
        final themeState = context.select((ThemeBloc bloc) => bloc.state);
        final bgrColor = themeState.currentTheme == ThemeMode.light
            ? AppColors.whiteFF
            : AppColors.darkBlue2A;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 110,
          decoration: BoxDecoration(
            borderRadius: AppProperty.allBorderRadiusMedium,
            color: bgrColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDropdownItem(
                context: context,
                dropdownValue: readingState
                    .readingItems[readingState.indexService].typeMeasure,
                inscription: AppLocalizations.of(context)!
                    .type_measurement_inscription
                    .toUpperCase(),
                hintText: AppLocalizations.of(context)!
                    .choose_measurement_button_inscription,
                valueList: ReadingTypeMeasure.dropdownTypeMeasure,
                onChanged: (String value) =>
                    BlocProvider.of<NewReadingBloc>(context).add(
                  NewReadingPickTypeMeasureEvent(value),
                ),
              ),
              _buildDropdownItem(
                dropdownValue: readingState
                    .readingItems[readingState.indexService].unitMeasure,
                context: context,
                inscription: AppLocalizations.of(context)!
                    .units_measurement_inscription
                    .toUpperCase(),
                hintText: AppLocalizations.of(context)!
                    .choose_unit_button_inscription,
                valueList: ReadingUnitsMeasure.dropdownUnitsMeasure,
                onChanged: (String value) =>
                    BlocProvider.of<NewReadingBloc>(context).add(
                  NewReadingPickUnitMeasureEvent(value),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

_buildDropdownItem({
  required BuildContext context,
  required String inscription,
  required String hintText,
  required String dropdownValue,
  required List<String> valueList,
  required Function(String) onChanged,
}) {
  return Expanded(
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final bgrColor = state.currentTheme == ThemeMode.light
            ? AppColors.whiteFF
            : AppColors.darkBlue2A;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(inscription,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              child: Center(
                child: DropdownButtonFormField(
                  isExpanded: true,
                  isDense: false,
                  itemHeight: 50,
                  value: dropdownValue,
                  style: Theme.of(context).textTheme.titleMedium,
                  dropdownColor: bgrColor,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.greyD9, width: 1),
                      borderRadius: AppProperty.allBorderRadiusMediumSmall,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.greyD9, width: 1),
                      borderRadius: AppProperty.allBorderRadiusMediumSmall,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.greyD9, width: 1),
                      borderRadius: AppProperty.allBorderRadiusMediumSmall,
                    ),
                  ),
                  onChanged: (String? newValue) {
                    dropdownValue = newValue!;
                    onChanged(newValue);
                  },
                  items: valueList.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(getMeasureDisplayName(value, context)),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

_buildSaveButton(BuildContext context) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, themeState) {
      final bgrColor = themeState.currentTheme == ThemeMode.light
          ? AppColors.whiteFF
          : AppColors.darkBlue2A;
      final shadow = themeState.currentTheme == ThemeMode.light
          ? AppColors.greyD9
          : AppColors.black00.withOpacity(0.3);
      return BlocBuilder<NewReadingBloc, NewReadingCreateState>(
        builder: (context, newReadingState) {
          final items = newReadingState.readingItems;
         String getCurrentUnitMeasure(){
           final unitMeasure =
           items[newReadingState.indexService ].unitMeasure == ReadingUnitsMeasure.undetectableUnits
               ? ''
               : getMeasureDisplayName(items[newReadingState.indexService].unitMeasure, context);
           return unitMeasure;
          }

          final locale = AppLocalizations.of(context)!;


    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: bgrColor,
          boxShadow: [
            BoxShadow(
              color: shadow,
              spreadRadius: 10,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        height: 80,
        child: Row(
          children: [
            items.isNotEmpty
                ? buildButtonsWithIcon(
              reading: items[newReadingState.indexService],
              icon: Icons.delete_outline_outlined,
              iconBgrColor: AppColors.red02,
              onFunc: () => BlocProvider.of<NewReadingBloc>(context).add(
                NewReadingDeleteServiceEvent(),
              ),

            )
                : const SizedBox(),
            const SizedBox(width: 5,),
            Expanded(
              child: buildElevationButton(
                buttonText: AppLocalizations.of(context)!.save_button_inscription,
                buttonAction: () {
                  if (textFieldKey.currentState == null) {
                    print("formKey.currentState is null!");
                  } else if (textFieldKey.currentState!.validate()) {
                    BlocProvider.of<NewReadingBloc>(context).add(
                      NewReadingSaveEvent(context),
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: 5,),
            items.isNotEmpty
            ? buildButtonsWithIcon(
                        reading: items[newReadingState.indexService],
                        icon: Icons.share,
                        iconBgrColor: AppColors.blueD7,
                        onFunc: () {
                          items[newReadingState.indexService].typeMeasure == ReadingTypeMeasure.undetectableType
                              ? Share.share('')
                              : items[newReadingState.indexService].typeMeasure == ReadingTypeMeasure.areaType
                              ? Share.share(
                              '${items[newReadingState.indexService].title}\n'
                                  '${locale.sum_inscription} ${newReadingState.readingItems[newReadingState.indexService].sum.toStringAsFixed(2)}')
                              : items[newReadingState.indexService].typeMeasure == ReadingTypeMeasure.fixedType
                              ? Share.share(
                              '${items[newReadingState.indexService].title}\n'
                                  '${locale.sum_inscription} ${items[newReadingState.indexService].sum.toStringAsFixed(2)}')
                              : items[newReadingState.indexService].typeMeasure == ReadingTypeMeasure.singleZoneMeterType
                              ? Share.share('${items[newReadingState.indexService].title}\n'
                              '${locale.current_readings_unit_hint_text}: ${items[newReadingState.indexService].currentReading}\n'
                              '${locale.used_inscription} ${items[newReadingState.indexService].used} ${getCurrentUnitMeasure()}'
                              '\n${locale.sum_inscription} ${items[newReadingState.indexService].sum.toStringAsFixed(2)}')
                              : items[newReadingState.indexService].typeMeasure == ReadingTypeMeasure.twoZoneMeterType
                              ?  Share.share('${items[newReadingState.indexService].title}\n'
                                 '${locale.current_indicators_day_share}: ${items[newReadingState.indexService].currentReadingDay}\n'
                                 '${locale.current_indicators_night_share}: ${items[newReadingState.indexService].currentReadingNight}\n'
                                 '${locale.used_day_inscription} ${items[newReadingState.indexService].usedDay} ${getCurrentUnitMeasure()}\n'
                                 '${locale.used_night_inscription} ${items[newReadingState.indexService].usedNight} ${getCurrentUnitMeasure()}\n'
                                 '${locale.sum_inscription} ${items[newReadingState.indexService].sum.toStringAsFixed(2)}')
                              : items[newReadingState.indexService].typeMeasure == ReadingTypeMeasure.threeZoneMeterType
                              ? Share.share('${items[newReadingState.indexService].title}\n'
                              '${locale.current_indicators_day_share}: ${items[newReadingState.indexService].currentReadingDay}\n'
                              '${locale.current_indicators_half_pick_share}: ${items[newReadingState.indexService].currentReadingHalfPeak}\n'
                              '${locale.current_indicators_night_share}: ${items[newReadingState.indexService].currentReadingNight}\n'
                              '${locale.used_day_inscription} ${items[newReadingState.indexService].usedDay} ${getCurrentUnitMeasure()}\n'
                              '${locale.used_half_peak_inscription} ${items[newReadingState.indexService].usedHalfPeak} ${getCurrentUnitMeasure()}\n'
                              '${locale.used_night_inscription} ${items[newReadingState.indexService].usedNight} ${getCurrentUnitMeasure()}\n'
                              '${locale.sum_inscription} ${items[newReadingState.indexService].sum.toStringAsFixed(2)}')
                               : Share.share('');
                          },
                      )
            : const SizedBox()
              ],
        ),
      );
  },
);
    },
  );
}


getMeasureDisplayName(String value, BuildContext ctx) {
  switch (value) {
    case ReadingTypeMeasure.undetectableType:
      return AppLocalizations.of(ctx)!.select_measurement_type_dropdown;
    case ReadingTypeMeasure.areaType:
      return AppLocalizations.of(ctx)!.by_area_dropdown;
    case ReadingTypeMeasure.fixedType:
      return AppLocalizations.of(ctx)!.fixed_dropdown;
    case ReadingTypeMeasure.singleZoneMeterType:
      return AppLocalizations.of(ctx)!.single_zone_meter_dropdown;
    case ReadingTypeMeasure.twoZoneMeterType:
      return AppLocalizations.of(ctx)!.two_zone_meter_dropdown;
    case ReadingTypeMeasure.threeZoneMeterType:
      return AppLocalizations.of(ctx)!.three_zone_meter_dropdown;

    case ReadingUnitsMeasure.undetectableUnits:
      return AppLocalizations.of(ctx)!.select_measurement_unit_dropdown;
    case ReadingUnitsMeasure.kWUnit:
      return AppLocalizations.of(ctx)!.kW_dropdown;
    case ReadingUnitsMeasure.m2Unit:
      return AppLocalizations.of(ctx)!.m2_dropdown;
    case ReadingUnitsMeasure.m3Unit:
      return AppLocalizations.of(ctx)!.m3_dropdown;
    case ReadingUnitsMeasure.gCalUnit:
      return AppLocalizations.of(ctx)!.gcal_dropdown;
    default:
      return '';
  }
}