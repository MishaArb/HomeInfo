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

  @override
  void dispose() {
    _priceController.dispose();
    _previousReadingController.dispose();
    _currentReadingController.dispose();
    _commentController.dispose();
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
                : getMeasureDisplayName(widget.reading.unitMeasure, context);
        _priceController.value = TextEditingValue(
          text: widget.reading.price,
          selection:
              TextSelection.collapsed(offset: widget.reading.price.length),
        );
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
          price: _priceController.text,
          previousReading: _previousReadingController.text,
          currentReading: _currentReadingController.text,
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
        );
      },
    );
  }
}
