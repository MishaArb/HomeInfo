part of '../create_or_edit_reading_screen.dart';

class ThreeZoneMeterType extends StatefulWidget {
  const ThreeZoneMeterType({super.key, required this.reading});

  final ReadingItem reading;

  @override
  State<ThreeZoneMeterType> createState() => _ThreeZoneMeterTypeState();
}

class _ThreeZoneMeterTypeState extends State<ThreeZoneMeterType> {
  final _priceController = TextEditingController();
  final _prevReadingDayController = TextEditingController();
  final _prevReadingNightController = TextEditingController();
  final _prevReadingHalfPeakController = TextEditingController();
  final _curReadingHalfPeakController = TextEditingController();
  final _curReadingDayController = TextEditingController();
  final _curReadingNightController = TextEditingController();
  final _dayZoneCoeffController = TextEditingController();
  final _nightZoneController = TextEditingController();
  final _halfPeakZoneCoeffController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    _prevReadingDayController.dispose();
    _prevReadingNightController.dispose();
    _prevReadingHalfPeakController.dispose();
    _curReadingHalfPeakController.dispose();
    _curReadingDayController.dispose();
    _curReadingNightController.dispose();
    _dayZoneCoeffController.dispose();
    _nightZoneController.dispose();
    _halfPeakZoneCoeffController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final bgrColor = state.currentTheme == ThemeMode.light
            ? AppColors.whiteFF
            : AppColors.darkBlue2A;
        final unitMeasure =
            widget.reading.unitMeasure == ReadingUnitsMeasure.undetectableUnits
                ? ''
                : getMeasureDisplayName(widget.reading.unitMeasure, context);
        _priceController.value = TextEditingValue(
          text: widget.reading.price,
          selection:
              TextSelection.collapsed(offset: widget.reading.price.length),
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
        _prevReadingHalfPeakController.value = TextEditingValue(
          text: widget.reading.previousReadingHalfPeak,
          selection: TextSelection.collapsed(
              offset: widget.reading.previousReadingHalfPeak.length),
        );
        _curReadingHalfPeakController.value = TextEditingValue(
          text: widget.reading.currentReadingHalfPeak,
          selection: TextSelection.collapsed(
              offset: widget.reading.currentReadingHalfPeak.length),
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
        _halfPeakZoneCoeffController.value = TextEditingValue(
          text: widget.reading.halfPeakZoneCoeff,
          selection: TextSelection.collapsed(
              offset: widget.reading.halfPeakZoneCoeff.length),
        );
        _commentController.value = TextEditingValue(
          text: widget.reading.comment,
          selection:
              TextSelection.collapsed(offset: widget.reading.comment.length),
        );
        NewReadingCalculateThreeZoneMeterEvent calculateThreeZoneMeterEvent =
            NewReadingCalculateThreeZoneMeterEvent(
          price: _priceController.text,
          previousReadingDay: _prevReadingDayController.text,
          previousReadingNight: _prevReadingNightController.text,
          previousReadingHalfPeak: _prevReadingHalfPeakController.text,
          currentReadingHalfPeak: _curReadingHalfPeakController.text,
          currentReadingDay: _curReadingDayController.text,
          currentReadingNight: _curReadingNightController.text,
          dayZoneCoeff: _dayZoneCoeffController.text,
          nightZoneCoeff: _nightZoneController.text,
          halfPeakZoneCoeff: _halfPeakZoneCoeffController.text,
          comment: _commentController.text,
        );
        return Form(
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
                        hintText: AppLocalizations.of(context)!
                            .current_readings_unit_hint_text,
                        onChanged: (value) =>
                            BlocProvider.of<NewReadingBloc>(context).add(
                          calculateThreeZoneMeterEvent.copyWith(
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
                          calculateThreeZoneMeterEvent.copyWith(
                            currentReadingHalfPeak:
                                _curReadingHalfPeakController.text,
                          ),
                        ),
                        controller: _curReadingHalfPeakController,
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
                          calculateThreeZoneMeterEvent.copyWith(
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
                          calculateThreeZoneMeterEvent.copyWith(
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
                          calculateThreeZoneMeterEvent.copyWith(
                            previousReadingHalfPeak:
                                _prevReadingHalfPeakController.text,
                          ),
                        ),
                        controller: _prevReadingHalfPeakController,
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
                          calculateThreeZoneMeterEvent.copyWith(
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
                          calculateThreeZoneMeterEvent.copyWith(
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
                          calculateThreeZoneMeterEvent.copyWith(
                            halfPeakZoneCoeff:
                                _halfPeakZoneCoeffController.text,
                          ),
                        ),
                        controller: _halfPeakZoneCoeffController,
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
                          calculateThreeZoneMeterEvent.copyWith(
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
                buildSimpleTextForm(
                  context: context,
                  hintText:
                      AppLocalizations.of(context)!.price_per_unit_hint_text,
                  onChanged: (value) =>
                      BlocProvider.of<NewReadingBloc>(context).add(
                    calculateThreeZoneMeterEvent.copyWith(
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
                ),
                buildDescriptionTextForm(
                  context: context,
                  hintText:
                      AppLocalizations.of(context)!.comment_unit_hint_text,
                  controller: TextEditingController(),
                  onChanged: (value) =>
                      BlocProvider.of<NewReadingBloc>(context).add(
                    calculateThreeZoneMeterEvent.copyWith(
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
                  title:
                      AppLocalizations.of(context)!.used_half_peak_inscription,
                  result:
                      '${widget.reading.usedHalfPeak.toStringAsFixed(2)} $unitMeasure',
                ),
                buildResultInscription(
                  context: context,
                  title: AppLocalizations.of(context)!.used_night_inscription,
                  result:
                      '${widget.reading.usedNight.toStringAsFixed(2)} $unitMeasure',
                ),
                buildResultInscription(
                  context: context,
                  title: AppLocalizations.of(context)!.sum_inscription,
                  result: '${widget.reading.sum.toStringAsFixed(2)}  грн',
                ),
                buildShareAndDeleteButton(
                  onShare: () {
                    Share.share('${widget.reading.title}\n'
                        '${AppLocalizations.of(context)!.current_indicators_day_share}: ${widget.reading.currentReadingDay}\n'
                        '${AppLocalizations.of(context)!.current_indicators_half_pick_share}: ${widget.reading.currentReadingHalfPeak}\n'
                        '${AppLocalizations.of(context)!.current_indicators_night_share}: ${widget.reading.currentReadingNight}\n'
                        '${AppLocalizations.of(context)!.used_day_inscription} ${widget.reading.usedDay} $unitMeasure\n'
                        '${AppLocalizations.of(context)!.used_half_peak_inscription} ${widget.reading.usedHalfPeak} $unitMeasure\n'
                        '${AppLocalizations.of(context)!.used_night_inscription} ${widget.reading.usedNight} $unitMeasure\n'
                        '${AppLocalizations.of(context)!.sum_inscription} ${widget.reading.sum.toStringAsFixed(2)}');
                  },
                  onDelete: () => BlocProvider.of<NewReadingBloc>(context).add(
                    NewReadingDeleteServiceEvent(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
