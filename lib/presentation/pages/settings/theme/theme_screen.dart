import 'package:flutter/material.dart';

import '../../../../core/asset_image/asset_image.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../widgets/app_bar/app_bar_with_arrow_back.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithArrowBack(title: 'Тема'),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildInscriptionScreen(context),
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.whiteFF,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Режим', style: Theme.of(context).textTheme.bodyMedium,),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildThemeItem(
                      context: context,
                      themeImg: AssetImages.lightThemeImage,
                      isThemeSelected: false,
                      title: 'Світла',
                      onTapAction: () {},
                    ),
                    _buildThemeItem(
                      context: context,
                      themeImg: AssetImages.darkThemeImage,
                      isThemeSelected: true,
                      title: 'Темна',
                      onTapAction: () {},
                    ),
                    _buildThemeItem(
                      context: context,
                      themeImg: AssetImages.systemThemeImage,
                      isThemeSelected: false,
                      title: 'Системна',
                      onTapAction: () {},
                    ),
                  ],
                ),
              ],
            ),
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
      'Pick the theme that resonates with your style and sets the mood for your app experience.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium,
    ),
  );
}


Column _buildThemeItem({
    required BuildContext context,
    required String themeImg,
    required bool isThemeSelected,
    required String title,
    required void Function() onTapAction
    }) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTapAction,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Text(title,  style: Theme.of(context).textTheme.bodyMedium,)
    ],
  );
}
