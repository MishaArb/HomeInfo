import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_property.dart';
import '../../bloc/currency/currency_bloc.dart';
import '../../widgets/buttons/elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildReminderNameTextForm(context),
          const SizedBox(height: 20),
          _buildBuildElevationButton(context)
        ],
      ),
    );
  }

  _buildReminderNameTextForm(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return AppLocalizations.of(context)!
                        .field_cant_be_empty_error_text;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppProperty.allBorderRadiusMedium,
                      borderSide: const BorderSide(color: AppColors.blueE),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppProperty.allBorderRadiusMedium,
                      borderSide:
                      BorderSide(color: AppColors.grey82.withOpacity(0.4)),
                    ),
                    hintText:AppLocalizations.of(context)!.currency_example_hint_text,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _buildBuildElevationButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: buildElevationButton(
        buttonText: AppLocalizations.of(context)!.save_button_inscription,
        buttonAction: () {
          if (_formKey.currentState!.validate()) {
            BlocProvider.of<CurrencyBloc>(context).add(
                SetCurrencyEvent(_textController.text));
          }

        },
      ),
    );
  }
}
