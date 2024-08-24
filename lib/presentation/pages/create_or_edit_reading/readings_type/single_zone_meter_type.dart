part of '../create_or_edit_reading_screen.dart';

class SingleZoneMeterType extends StatefulWidget {
  const SingleZoneMeterType({super.key, required this.reading});

  final ReadingItem reading;

  @override
  State<SingleZoneMeterType> createState() => _SingleZoneMeterTypeState();
}

class _SingleZoneMeterTypeState extends State<SingleZoneMeterType> {
  final _priceController = TextEditingController();
  final _previousReadingController = TextEditingController();
  final _currentReadingController = TextEditingController();
  final _commentController = TextEditingController();
  final _thresholdBeforeController = TextEditingController();
  final _thresholdAfterController = TextEditingController();
  final _priceThresholdBeforeController = TextEditingController();
  final _priceThresholdAfterController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    _previousReadingController.dispose();
    _currentReadingController.dispose();
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
        final threshold = widget.reading.threshold;
        _previousReadingController.value = TextEditingValue(
          text: widget.reading.previousReading,
          selection: TextSelection.collapsed(
              offset: widget.reading.previousReading.length),
        );
        _currentReadingController.value = TextEditingValue(
          text: widget.reading.currentReading,
          selection: TextSelection.collapsed(
              offset: widget.reading.currentReading.length),
        );
        _commentController.value = TextEditingValue(
          text: widget.reading.comment,
          selection:
              TextSelection.collapsed(offset: widget.reading.comment.length),
        );

        NewReadingCalculateSingleZoneMeterEvent calculateSingleZoneMeterEvent =
            NewReadingCalculateSingleZoneMeterEvent(
              threshold: threshold,
          price: _priceController.text,
          priceThresholdBefore: _priceThresholdBeforeController.text,
          priceThresholdAfter: _priceThresholdAfterController.text,
          thresholdBefore: _thresholdBeforeController.text,
          thresholdAfter: _thresholdAfterController.text,
          previousReading: _previousReadingController.text,
          currentReading: _currentReadingController.text,
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
                    buildSimpleTextForm(
                      context: context,
                      hintText: AppLocalizations.of(context)!
                          .current_readings_unit_hint_text,
                      onChanged: (value) =>
                          BlocProvider.of<NewReadingBloc>(context).add(
                        calculateSingleZoneMeterEvent.copyWith(
                          currentReading: _currentReadingController.text,
                        ),
                      ),
                      controller: _currentReadingController,
                      validateAction: (String? value) {
                        if (value!.trim().isEmpty) {
                          return AppLocalizations.of(context)!
                              .field_cant_be_empty_error_text;
                        } else {
                          return null;
                        }
                      },
                    ),
                    buildSimpleTextForm(
                      context: context,
                      hintText: AppLocalizations.of(context)!
                          .previous_readings_unit_hint_text,
                      onChanged: (value) =>
                          BlocProvider.of<NewReadingBloc>(context).add(
                        calculateSingleZoneMeterEvent.copyWith(
                          previousReading: _previousReadingController.text,
                        ),
                      ),
                      controller: _previousReadingController,
                      validateAction: (String? value) {
                        if (value!.trim().isEmpty) {
                          return AppLocalizations.of(context)!
                              .field_cant_be_empty_error_text;
                        } else {
                          return null;
                        }
                      },
                    ),
                    !threshold ?
                    buildSimpleTextForm(
                      context: context,
                      hintText:
                          AppLocalizations.of(context)!.price_per_unit_hint_text,
                      onChanged: (value) => BlocProvider.of<NewReadingBloc>(context)
                          .add(calculateSingleZoneMeterEvent.copyWith(
                        price: _priceController.text,
                      )),
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
                                        .add(calculateSingleZoneMeterEvent.copyWith(
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
                                hintText: AppLocalizations.of(context)!
                                    .price_before_hint_text,
                                onChanged: (value) =>
                                    BlocProvider.of<NewReadingBloc>(context)
                                        .add(calculateSingleZoneMeterEvent.copyWith(
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
                                      hintText: AppLocalizations.of(context)!
                                              .threshold_after_hint_text +
                                          (unitMeasure.isNotEmpty
                                              ? ' ($unitMeasure)'
                                              : ""),
                                      onChanged: (value) =>
                                    BlocProvider.of<NewReadingBloc>(context)
                                        .add(calculateSingleZoneMeterEvent.copyWith(
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
                                        .add(calculateSingleZoneMeterEvent.copyWith(
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
                        calculateSingleZoneMeterEvent.copyWith(
                          comment: _commentController.text,
                        ),
                      ),
                    ),
                    buildResultInscription(
                      context: context,
                      title: AppLocalizations.of(context)!.used_inscription,
                      result:
                          '${widget.reading.used.toStringAsFixed(2)} $unitMeasure',
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
