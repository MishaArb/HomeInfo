import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_info/core/constants/app_colors.dart';
import '../../../../core/constants/app_property.dart';
import '../../../../core/constants/asset_image.dart';
import '../../../bloc/theme/theme_bloc.dart';
import '../../../widgets/buttons/elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewServiceBottomSheet extends StatelessWidget {
  const NewServiceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const NewServiceBottomSheetWidget();
  }
}

class NewServiceBottomSheetWidget extends StatelessWidget {
  const NewServiceBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final bgrColor = state.currentTheme == ThemeMode.light
            ? AppColors.whiteFF
            : AppColors.darkBlue2A;
        final shadow = state.currentTheme == ThemeMode.light
            ? AppColors.greyD9
            : AppColors.black00.withOpacity(0.2);

        return Container(
          height: 450,
          decoration: BoxDecoration(
            color: bgrColor,
            borderRadius: AppProperty.topRightTopLeftBorderRadiusMedium,
            boxShadow: [
              BoxShadow(
                color: shadow,
                spreadRadius: 10,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context, AppLocalizations.of(context)!.new_service_screen_title),
              _buildNameServiceTextForm(context),
              _buildInscriptionScreen(context, AppLocalizations.of(context)!.select_icon_inscription),
              _buildSelectIconLisView(),
              _buildInscriptionScreen(context, AppLocalizations.of(context)!.select_color_inscription),
              _buildSelectColorLisView(),
              _buildBuildElevationButton(context),
            ],
          ),
        );
      },
    );
  }
}

_buildTitle(BuildContext context, String title) {
  return Center(
    child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
  );
}

_buildInscriptionScreen(BuildContext context, String inscription) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Text(inscription, style: Theme.of(context).textTheme.bodyMedium),
  );
}

_buildNameServiceTextForm(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: TextFormField(
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      maxLines: 1,
      controller: TextEditingController(),
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.title_hint_text,
      ),
    ),
  );
}

_buildSelectIconLisView() {
  return SizedBox(
    height: 72,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: AssetImagesConstant.servicesImg.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(2),
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: AppProperty.allBorderRadiusExtraExtraLarge,
              border: Border.all(width: 2, color: AppColors.blueE),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.blue8F,
                borderRadius: AppProperty.allBorderRadiusExtraExtraLarge,
                border: Border.all(width: 1, color: AppColors.grey82),
              ),
              child: Image(
                image: AssetImage(
                  AssetImagesConstant.servicesImg[index],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

_buildSelectColorLisView() {
  return SizedBox(
    height: 72,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: AppColors.servicesColors.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(2),
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: AppProperty.allBorderRadiusExtraExtraLarge,
              border: Border.all(width: 2, color: AppColors.blueE),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.servicesColors[index],
                borderRadius: AppProperty.allBorderRadiusExtraExtraLarge,
                border: Border.all(width: 1, color: AppColors.grey82),
              ),
            ),
          ),
        );
      },
    ),
  );
}

_buildBuildElevationButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: buildElevationButton(
      buttonText: AppLocalizations.of(context)!.save_button_inscription,
      buttonAction: () {
        print('Зберегти');
      },
    ),
  );
}