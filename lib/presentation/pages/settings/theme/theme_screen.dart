import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_info/core/constants/app_property.dart';
import 'package:home_info/presentation/bloc/theme/theme_bloc.dart';
import '../../../../core/constants/asset_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/app_bar/app_bar_with_arrow_back.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
@RoutePage()
class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithArrowBack(
        title: AppLocalizations.of(context)!.theme_app_bar_title,
        onPressedAction: () => context.router.back(),
      ),
      body: const ThemeScreenView(),
    );
  }
}

class ThemeScreenView extends StatelessWidget {
  const ThemeScreenView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final themeBloc = BlocProvider.of<ThemeBloc>(context);
        final bgrColor = state.currentTheme == ThemeMode.light
            ? AppColors.whiteFF
            : AppColors.darkBlue2A;
        return SingleChildScrollView(
          child: Column(
            children: [
              _buildInscriptionScreen(context),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: bgrColor,
                    borderRadius: AppProperty.allBorderRadiusSmall,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.mode_screen_title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildThemeItem(
                          context: context,
                          themeImg: AssetImagesConstant.lightThemeImage,
                          isThemeSelected: state.isLightTheme,
                          title: AppLocalizations.of(context)!.light_button_inscription,
                          onTapAction: () => themeBloc.add(ThemeLightEvent()),
                        ),
                        _buildThemeItem(
                          context: context,
                          themeImg: AssetImagesConstant.darkThemeImage,
                          isThemeSelected: state.isDarkTheme,
                          title: AppLocalizations.of(context)!.dark_button_inscription,
                          onTapAction: () => themeBloc.add(ThemeDarkEvent()),
                        ),
                        _buildThemeItem(
                          context: context,
                          themeImg: AssetImagesConstant.systemThemeImage,
                          isThemeSelected: state.isSystemTheme,
                          title: AppLocalizations.of(context)!.system_button_inscription,
                          onTapAction: () => themeBloc.add(ThemeSystemEvent()),
                        ),
                      ],
                    ),
                  ],
                ),
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
      AppLocalizations.of(context)!.theme_screen_description,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium,
    ),
  );
}

Column _buildThemeItem(
    {required BuildContext context,
    required String themeImg,
    required bool isThemeSelected,
    required String title,
    required void Function() onTapAction}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTapAction,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: AppProperty.allBorderRadiusMedium,
            border: Border.all(
              width: 3,
              color: isThemeSelected ? AppColors.blueE : Colors.transparent,
            ),
          ),
          child: Container(
            width: 75,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: AppColors.greyD9,
              ),
              image: DecorationImage(
                image: AssetImage(themeImg),
                fit: BoxFit.fill,
              ),
              //
              borderRadius: AppProperty.allBorderRadiusSmall,
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      )
    ],
  );
}
