import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/settings_locale.dart';
import '../../../bloc/locale/locale_bloc.dart';
import '../../../widgets/app_bar/app_bar_with_arrow_back.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
@RoutePage()
class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LanguageScreenView();
  }
}

class LanguageScreenView extends StatelessWidget {
  const LanguageScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        final localeBloc = BlocProvider.of<LocaleBloc>(context);
        return Scaffold(
          appBar: buildAppBarWithArrowBack(
            title: AppLocalizations.of(context)!.language_app_bar_title,
            onPressedAction: () => context.router.back(),
          ),
          body: Column(
            children: [
              _buildInscriptionScreen(context),
              _buildCountryItem(
                context: context,
                countryCode: 'ua',
                countryLanguage: 'Українська',
                boxValue: state.isUkrainian,
                onChangedAction: (value) =>
                    localeBloc.add(LocaleChangeEvent(SettingsLocale.ukrainian)),
              ),
              _buildCountryItem(
                context: context,
                countryCode: 'GB',
                countryLanguage: 'English',
                boxValue: state.isEnglish,
                onChangedAction: (value) =>
                    localeBloc.add(LocaleChangeEvent(SettingsLocale.english)),
              ),
            ],
          ),
        );
      },
    );
  }
}

Padding _buildInscriptionScreen(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(40.0),
    child: Text(
      AppLocalizations.of(context)!.language_screen_description,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium,
    ),
  );
}

ListTile _buildCountryItem({
  required BuildContext context,
  required String countryCode,
  required String countryLanguage,
  required bool boxValue,
  required void Function(bool value) onChangedAction,
}) {
  return ListTile(
    minLeadingWidth: 50,
    contentPadding: const EdgeInsets.symmetric(horizontal: 50),
    leading: Text(
      countryCode
          .toUpperCase()
          .split('')
          .map((char) => 127397 + char.codeUnitAt(0))
          .map((code) => String.fromCharCode(code))
          .join(),
      style: const TextStyle(fontSize: 30),
    ),
    title: Text(
      countryLanguage,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    trailing: Transform.scale(
      scale: 1.3,
      child: Checkbox(value: boxValue, onChanged: (value) => onChangedAction(value!)),
    ),
  );
}
