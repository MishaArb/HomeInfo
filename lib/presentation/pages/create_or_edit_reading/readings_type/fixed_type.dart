part of '../create_or_edit_reading_screen.dart';

class FixedType extends StatefulWidget {
  const FixedType({super.key, required this.reading});

  final ReadingItem reading;

  @override
  State<FixedType> createState() => _FixedTypeState();
}

class _FixedTypeState extends State<FixedType> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
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
        _priceController.value = TextEditingValue(
          text: widget.reading.price,
          selection:
              TextSelection.collapsed(offset: widget.reading.price.length),
        );
        _commentController.value = TextEditingValue(
          text: widget.reading.comment,
          selection:
              TextSelection.collapsed(offset: widget.reading.comment.length),
        );
        NewReadingCalculateFixedEvent calculateFixedEvent =
            NewReadingCalculateFixedEvent(
          price: _priceController.text,
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
                  hintText: AppLocalizations.of(context)!.price_hint_text,
                  onChanged: (value) =>
                      BlocProvider.of<NewReadingBloc>(context).add(
                    calculateFixedEvent.copyWith(
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
                  controller: _commentController,
                  onChanged: (value) =>
                      BlocProvider.of<NewReadingBloc>(context).add(
                    calculateFixedEvent.copyWith(
                      comment: _commentController.text,
                    ),
                  ),
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
