import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_info/core/constants/app_colors.dart';
import '../../../../core/constants/app_property.dart';
import '../../../../core/constants/asset_image.dart';
import '../../../../injection_container.dart';
import '../../../bloc/home_service/home_services/home_services_bloc.dart';
import '../../../bloc/home_service/new_home_service/new_home_service_bloc.dart';
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

class NewServiceBottomSheetWidget extends StatefulWidget {
  const NewServiceBottomSheetWidget({
    super.key,
  });

  @override
  State<NewServiceBottomSheetWidget> createState() =>
      _NewServiceBottomSheetWidgetState();
}

class _NewServiceBottomSheetWidgetState
    extends State<NewServiceBottomSheetWidget> {
  final TextEditingController _titleController = TextEditingController();
  final textFieldKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewHomeServiceBloc>(
      create: (context) => getIt(),
      child: BlocListener<NewHomeServiceBloc, NewHomeServiceState>(
        listenWhen: (previous, current) => current is NewHomeServiceSaveState,
        listener: (context, state) {
          BlocProvider.of<HomeServicesBloc>(context)
              .add(HomeServicesFetchEvent());
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final bgrColor = state.currentTheme == ThemeMode.light
                ? AppColors.whiteFF
                : AppColors.darkBlue2A;
            final shadow = state.currentTheme == ThemeMode.light
                ? AppColors.greyD9
                : AppColors.black00.withOpacity(0.2);

            return Form(
              key: textFieldKey,
              child: Container(
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
                    _buildTitle(
                        AppLocalizations.of(context)!.new_service_screen_title),
                    _buildNameServiceTextForm(),
                    _buildInscriptionScreen(
                        AppLocalizations.of(context)!.select_icon_inscription),
                    _buildSelectIconLisView(),
                    _buildInscriptionScreen(
                        AppLocalizations.of(context)!.select_color_inscription),
                    _buildSelectColorLisView(),
                    _buildBuildElevationButton(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildTitle(String title) {
    return Center(
      child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  _buildInscriptionScreen(String inscription) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(inscription, style: Theme.of(context).textTheme.bodyMedium),
    );
  }

  _buildNameServiceTextForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        maxLines: 1,
        controller: _titleController,
        validator: (text) {
          if (text!.trim().isEmpty) {
            return AppLocalizations.of(context)!.field_cant_be_empty_error_text;
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.title_hint_text,
        ),
      ),
    );
  }

  _buildSelectIconLisView() {
    return BlocBuilder<NewHomeServiceBloc, NewHomeServiceState>(
      builder: (context, state) {
        return SizedBox(
          height: 72,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AssetImagesConstant.servicesImg.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<NewHomeServiceBloc>(context)
                      .add(NewHomeServiceSelectIconEvent(icon: index));
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.all(2),
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                      borderRadius: AppProperty.allBorderRadiusExtraExtraLarge,
                      border: state.icon == index
                          ? Border.all(width: 3, color: AppColors.blueE)
                          : null),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.blueE.withOpacity(0.5),
                      borderRadius: AppProperty.allBorderRadiusExtraExtraLarge,
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
      },
    );
  }

  _buildSelectColorLisView() {
    return BlocBuilder<NewHomeServiceBloc, NewHomeServiceState>(
      builder: (context, state) {
        return SizedBox(
          height: 72,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppColors.servicesColors.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<NewHomeServiceBloc>(context).add(
                      NewHomeServiceSelectIconColorEvent(iconColor: index));
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.all(2),
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                      borderRadius: AppProperty.allBorderRadiusExtraExtraLarge,
                      border: state.iconColor == index
                          ? Border.all(width: 3, color: AppColors.blueE)
                          : null),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.servicesColors[index],
                      borderRadius: AppProperty.allBorderRadiusExtraExtraLarge,
                    ),
                  ),
                ),
              );
            },
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
          if (textFieldKey.currentState!.validate()) {
            BlocProvider.of<NewHomeServiceBloc>(context).add(
              ServiceSaveEvent(_titleController.text, context),
            );
          }
        },
      ),
    );
  }
}
