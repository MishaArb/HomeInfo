import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:home_info/injection_container.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_property.dart';
import '../../../../core/constants/asset_image.dart';
import '../../../../domain/entities/service_entity.dart';
import '../../../bloc/home_service/home_services/home_services_bloc.dart';
import '../../../bloc/reading/new_reading/new_reading_bloc.dart';
import '../../../widgets/alert_dialog/delete_alert_dialog.dart';
import '../../../widgets/app_bar/app_bar_with_arrow_back.dart';
import 'new_service_bottom_sheet.dart';

@RoutePage()
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key, required this.blocContext});

  final BuildContext blocContext;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeServicesBloc>(
      create: (context) => getIt()..add(HomeServicesFetchEvent()),
      child: BlocBuilder<HomeServicesBloc, HomeServicesState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBarWithArrowBack(
              title:
                  AppLocalizations.of(context)!.services_record_app_bar_title,
              onPressedAction: () {
                context.router.pop();
              },
            ),
            body: state is HomeServicesSuccessState
                ? _buildServicesItem(state.services, blocContext)
                : const SizedBox(),
            floatingActionButton: _buildFloatingActionButton(context),
          );
        },
      ),
    );
  }

  _buildServicesItem(List<HomeServiceEntity> services, BuildContext ctx) {
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<NewReadingBloc>(ctx).add(
              NewReadingAddHomeServiceEvent(
                context: ctx,
                icon: services[index].icon,
                iconColor: services[index].iconColor,
                title: services[index].title,
              ),
            );
          },
          child: Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (v) => buildDeleteAlertDialog(
                    context,
                    () {
                      BlocProvider.of<HomeServicesBloc>(context).add(
                        HomeServicesDeleteEvent(
                          id: services[index].id,
                          context: context,
                        ),
                      );
                    },
                  ),
                  backgroundColor: AppColors.red02,
                  foregroundColor: AppColors.whiteFF,
                  icon: Icons.delete,
                  label:
                      AppLocalizations.of(context)!.delete_button_inscription,
                ),
              ],
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(5),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.servicesColors[services[index].iconColor],
                  borderRadius: AppProperty.allBorderRadiusExtraLarge,
                ),
                child: Image(
                  image: AssetImage(
                    AssetImagesConstant.servicesImg[services[index].icon],
                  ),
                ),
              ),
              title: Text(
                services[index].title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        );
      },
    );
  }

  _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showSelectIconBottomSheet(context),
      backgroundColor: AppColors.blueE,
      child: const Icon(
        Icons.add,
        color: AppColors.whiteFF,
      ),
    );
  }

  _showSelectIconBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.black,
      barrierColor: Colors.transparent,
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<HomeServicesBloc>(context),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const NewServiceBottomSheet(),
          ),
        );
      },
    );
  }
}
