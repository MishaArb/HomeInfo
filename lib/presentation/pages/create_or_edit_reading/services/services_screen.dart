import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_property.dart';
import '../../../widgets/app_bar/app_bar_with_arrow_back.dart';
import '../create_or_edit_reading_screen.dart';
import 'new_service_bottom_sheet.dart';

@RoutePage()
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithArrowBack(
        title:  AppLocalizations.of(context)!.services_record_app_bar_title,
        onPressedAction: () {
          context.router.pop();
        },
      ),
      body: ListView.builder(
          itemCount: serviceList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(5),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: serviceList[index].iconColor,
                  borderRadius: AppProperty.allBorderRadiusExtraLarge,
                ),
                child: Image(image: AssetImage(serviceList[index].img)),
              ),
              title: Text(
                serviceList[index].name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
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
    builder: (BuildContext context) {
      return Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const NewServiceBottomSheet(),
      );
    },
  );
}