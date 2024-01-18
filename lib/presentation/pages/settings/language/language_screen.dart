import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../widgets/app_bar/app_bar_with_arrow_back.dart';

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
    return Scaffold(
      appBar: buildAppBarWithArrowBack(
        title: 'Мова',
        onPressedAction: () => context.router.back(),
        ),
      body: Column(
        children: [
          _buildInscriptionScreen(context),
          _buildCountryItem(
            context: context,
            countryCode: 'ua',
            countryLanguage: 'Українська',
            onChangedAction: (value) {},
          ),
          _buildCountryItem(
            context: context,
            countryCode: 'GB',
            countryLanguage: 'English',
            onChangedAction: (value) {},
          ),
        ],
      ),
    );
  }
}

Padding _buildInscriptionScreen(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(40.0),
    child: Text(
      'Select your preferred language and make the app truly yours. Customize your experience by choosing the language that speaks to you',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium,
    ),
  );
}

ListTile _buildCountryItem({
  required BuildContext context,
  required String countryCode,
  required String countryLanguage,
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
      child: Checkbox(value: true, onChanged: (value) => onChangedAction),
    ),
  );
}
