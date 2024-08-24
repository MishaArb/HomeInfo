part of '../create_or_edit_reading_screen.dart';

class TwoZoneMeterType extends StatefulWidget {
  const TwoZoneMeterType({super.key, required this.reading});

  final ReadingItem reading;

  @override
  State<TwoZoneMeterType> createState() => _TwoZoneMeterTypeState();
}

class _TwoZoneMeterTypeState extends State<TwoZoneMeterType> {
  final _priceController = TextEditingController();
  final _prevReadingDayController = TextEditingController();
  final _prevReadingNightController = TextEditingController();
  final _curReadingDayController = TextEditingController();
  final _curReadingNightController = TextEditingController();
  final _dayZoneCoeffController = TextEditingController();
  final _nightZoneController = TextEditingController();
  final _commentController = TextEditingController();
  final _thresholdBeforeController = TextEditingController();
  final _thresholdAfterController = TextEditingController();
  final _priceThresholdBeforeController = TextEditingController();
  final _priceThresholdAfterController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    _prevReadingDayController.dispose();
    _prevReadingNightController.dispose();
    _curReadingDayController.dispose();
    _curReadingNightController.dispose();
    _dayZoneCoeffController.dispose();
    _nightZoneController.dispose();
    _commentController.dispose();
    _thresholdBeforeController.dispose();
    _thresholdAfterController.dispose();
    _priceThresholdBeforeController.dispose();
    _priceThresholdAfterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final themeState = context.select((ThemeBloc bloc) => bloc.state);
        final currencyState = context.select((CurrencyBloc bloc) => bloc.state);
        final bgrColor = themeState.currentTheme == ThemeMode.light
            ? AppColors.whiteFF
            : AppColors.darkBlue2A;
        final unitMeasure =
            widget.reading.unitMeasure == ReadingUnitsMeasure.undetectableUnits
                ? ''
                : getDropDownMeasureLabel(widget.reading.unitMeasure, context);
        final threshold = widget.reading.threshold;
        _priceController.value = TextEditingValue(
          text: widget.reading.price,
          selection:
              TextSelection.collapsed(offset: widget.reading.price.length),
        );
        _priceThresholdBeforeController.value = TextEditingValue(
          text: widget.reading.priceThresholdBefore,
          selection:
          TextSelection.collapsed(offset: widget.reading.priceThresholdBefore.length),
        );
        _priceThresholdAfterController.value = TextEditingValue(
          text: widget.reading.priceThresholdAfter,
          selection:
          TextSelection.collapsed(offset: widget.reading.priceThresholdAfter.length),
        );
        _thresholdBeforeController.value = TextEditingValue(
          text: widget.reading.thresholdBefore,
          selection:
          TextSelection.collapsed(offset: widget.reading.thresholdBefore.length),
        );
        _thresholdAfterController.value = TextEditingValue(
          text: widget.reading.thresholdAfter,
          selection:
          TextSelection.collapsed(offset: widget.reading.thresholdAfter.length),
        );
        _prevReadingDayController.value = TextEditingValue(
          text: widget.reading.previousReadingDay,
          selection: TextSelection.collapsed(
              offset: widget.reading.previousReadingDay.length),
        );
        _prevReadingNightController.value = TextEditingValue(
          text: widget.reading.previousReadingNight,
          selection: TextSelection.collapsed(
              offset: widget.reading.previousReadingNight.length),
        );
        _curReadingDayController.value = TextEditingValue(
          text: widget.reading.currentReadingDay,
          selection: TextSelection.collapsed(
              offset: widget.reading.currentReadingDay.length),
        );
        _curReadingNightController.value = TextEditingValue(
          text: widget.reading.currentReadingNight,
          selection: TextSelection.collapsed(
              offset: widget.reading.currentReadingNight.length),
        );
        _dayZoneCoeffController.value = TextEditingValue(
          text: widget.reading.dayZoneCoeff,
          selection: TextSelection.collapsed(
              offset: widget.reading.dayZoneCoeff.length),
        );
        _nightZoneController.value = TextEditingValue(
          text: widget.reading.nightZoneCoeff,
          selection: TextSelection.collapsed(
              offset: widget.reading.nightZoneCoeff.length),
        );
        _commentController.value = TextEditingValue(
          text: widget.reading.comment,
          selection:
              TextSelection.collapsed(offset: widget.reading.comment.length),
        );

        NewReadingCalculateTwoZoneMeterEvent calculateTwoZoneMeterEvent =
            NewReadingCalculateTwoZoneMeterEvent(
          threshold: threshold,
          price: _priceController.text,
          priceThresholdBefore: _priceThresholdBeforeController.text,
          priceThresholdAfter: _priceThresholdAfterController.text,
          thresholdBefore: _thresholdBeforeController.text,
          thresholdAfter: _thresholdAfterController.text,
          previousReadingDay: _prevReadingDayController.text,
          previousReadingNight: _prevReadingNightController.text,
          currentReadingDay: _curReadingDayController.text,
          currentReadingNight: _curReadingNightController.text,
          dayZoneCoeff: _dayZoneCoeffController.text,
          nightZoneCoeff: _nightZoneController.text,
          comment: _commentController.text,
        );

        return Column(
          children: [
            buildThreshold(bgrColor, context, threshold),
            Form(
              key: textFieldKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: AppProperty.allBorderRadiusMedium,
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
                            hintText: AppLocalizations.of(context)!
                                .current_readings_unit_hint_text,
                            onChanged: (value) =>
                                BlocProvider.of<NewReadingBloc>(context).add(
                              calculateTwoZoneMeterEvent.copyWith(
                                currentReadingDay: _curReadingDayController.text,
                              ),
                            ),
                            controller: _curReadingDayController,
                            validateAction: (String? value) {
                              if (value!.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .field_cant_be_empty_error_text;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: buildSimpleTextForm(
                            context: context,
                            hintText: AppLocalizations.of(context)!
                                .current_readings_unit_hint_text,
                            onChanged: (value) =>
                                BlocProvider.of<NewReadingBloc>(context).add(
                              calculateTwoZoneMeterEvent.copyWith(
                                currentReadingNight:
                                    _curReadingNightController.text,
                              ),
                            ),
                            controller: _curReadingNightController,
                            validateAction: (String? value) {
                              if (value!.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .field_cant_be_empty_error_text;
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: buildSimpleTextForm(
                            context: context,
                            hintText: AppLocalizations.of(context)!
                                .previous_readings_unit_hint_text,
                            onChanged: (value) =>
                                BlocProvider.of<NewReadingBloc>(context).add(
                              calculateTwoZoneMeterEvent.copyWith(
                                previousReadingDay: _prevReadingDayController.text,
                              ),
                            ),
                            controller: _prevReadingDayController,
                            validateAction: (String? value) {
                              if (value!.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .field_cant_be_empty_error_text;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: buildSimpleTextForm(
                            context: context,
                            hintText: AppLocalizations.of(context)!
                                .previous_readings_unit_hint_text,
                            onChanged: (value) =>
                                BlocProvider.of<NewReadingBloc>(context).add(
                              calculateTwoZoneMeterEvent.copyWith(
                                previousReadingNight:
                                    _prevReadingNightController.text,
                              ),
                            ),
                            controller: _prevReadingNightController,
                            validateAction: (String? value) {
                              if (value!.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .field_cant_be_empty_error_text;
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: buildSimpleTextForm(
                            context: context,
                            hintText: AppLocalizations.of(context)!
                                .zonal_coefficient_hint_text,
                            onChanged: (value) =>
                                BlocProvider.of<NewReadingBloc>(context).add(
                              calculateTwoZoneMeterEvent.copyWith(
                                dayZoneCoeff: _dayZoneCoeffController.text,
                              ),
                            ),
                            controller: _dayZoneCoeffController,
                            validateAction: (String? value) {
                              if (value!.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .field_cant_be_empty_error_text;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: buildSimpleTextForm(
                            context: context,
                            hintText: AppLocalizations.of(context)!
                                .zonal_coefficient_hint_text,
                            onChanged: (value) =>
                                BlocProvider.of<NewReadingBloc>(context).add(
                              calculateTwoZoneMeterEvent.copyWith(
                                nightZoneCoeff: _nightZoneController.text,
                              ),
                            ),
                            controller: _nightZoneController,
                            validateAction: (String? value) {
                              if (value!.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .field_cant_be_empty_error_text;
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    !threshold ?
                    buildSimpleTextForm(
                      context: context,
                      hintText:
                          AppLocalizations.of(context)!.price_per_unit_hint_text,
                      onChanged: (value) =>
                          BlocProvider.of<NewReadingBloc>(context).add(
                        calculateTwoZoneMeterEvent.copyWith(
                          price: _priceController.text,
                        ),
                      ),
                      controller: _priceController,
                      validateAction: (String? value) {
                        if (value!.trim().isEmpty) {
                          return AppLocalizations.of(context)!
                              .field_cant_be_empty_error_text;
                        } else {
                          return null;
                        }
                      },
                    )
                        :
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                    child: buildSimpleTextForm(
                                      context: context,
                                      hintText: AppLocalizations.of(context)!
                                              .threshold_before_hint_text +
                                          (unitMeasure.isNotEmpty
                                              ? ' ($unitMeasure)'
                                              : ""),
                                      onChanged: (value) =>
                                    BlocProvider.of<NewReadingBloc>(context)
                                        .add(calculateTwoZoneMeterEvent.copyWith(
                                      thresholdBefore: _thresholdBeforeController.text,
                                    )),
                                controller: _thresholdBeforeController,
                                validateAction: (String? value) {
                                  if (value!.trim().isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .field_cant_be_empty_error_text;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: buildSimpleTextForm(
                                context: context,
                                hintText: AppLocalizations.of(context)!.price_before_hint_text,
                                onChanged: (value) =>
                                    BlocProvider.of<NewReadingBloc>(context)
                                        .add(calculateTwoZoneMeterEvent.copyWith(
                                      priceThresholdBefore: _priceThresholdBeforeController.text,
                                    )),
                                controller: _priceThresholdBeforeController,
                                validateAction: (String? value) {
                                  if (value!.trim().isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .field_cant_be_empty_error_text;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: buildSimpleTextForm(
                                context: context,
                                hintText: AppLocalizations.of(context)!.threshold_after_hint_text +
                                    (unitMeasure.isNotEmpty ? ' ($unitMeasure)' : ""),
                                onChanged: (value) =>
                                    BlocProvider.of<NewReadingBloc>(context)
                                        .add(calculateTwoZoneMeterEvent.copyWith(
                                      thresholdAfter: _thresholdAfterController.text,
                                    )),
                                controller: _thresholdAfterController,
                                validateAction: (String? value) {
                                  if (value!.trim().isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .field_cant_be_empty_error_text;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: buildSimpleTextForm(
                                context: context,
                                hintText: AppLocalizations.of(context)!
                                    .price_after_hint_text,
                                onChanged: (value) =>
                                    BlocProvider.of<NewReadingBloc>(context)
                                        .add(calculateTwoZoneMeterEvent.copyWith(
                                      priceThresholdAfter: _priceThresholdAfterController.text,
                                    )),
                                controller: _priceThresholdAfterController,
                                validateAction: (String? value) {
                                  if (value!.trim().isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .field_cant_be_empty_error_text;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    buildDescriptionTextForm(
                      context: context,
                      hintText:
                          AppLocalizations.of(context)!.comment_unit_hint_text,
                      controller: _commentController,
                      onChanged: (value) =>
                          BlocProvider.of<NewReadingBloc>(context).add(
                        calculateTwoZoneMeterEvent.copyWith(
                          comment: _commentController.text,
                        ),
                      ),
                    ),
                    buildResultInscription(
                      context: context,
                      title: AppLocalizations.of(context)!.used_day_inscription,
                      result:
                          '${widget.reading.usedDay.toStringAsFixed(2)} $unitMeasure',
                    ),
                    buildResultInscription(
                      context: context,
                      title: AppLocalizations.of(context)!.used_night_inscription,
                      result:
                          '${widget.reading.usedNight.toStringAsFixed(2)}  $unitMeasure',
                    ),
                    buildResultInscription(
                      context: context,
                      title: AppLocalizations.of(context)!.sum_inscription,
                      result: '${widget.reading.sum.toStringAsFixed(2)} ${currencyState.currency}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
