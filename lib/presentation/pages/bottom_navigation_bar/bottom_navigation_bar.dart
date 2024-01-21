import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/router/router.dart';
import '../../../core/themes/app_colors.dart';

@RoutePage()
class BottomNavigationBarScreen extends StatelessWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [HomeRoute(), ReadingsRoute(), SettingsRoute()],
      builder: (context, child) {
        final tabRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabRouter.activeIndex,
            onTap: (value) {
              tabRouter.setActiveIndex(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppLocalizations.of(context)!.home_button_inscription,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.list_alt),
                label:AppLocalizations.of(context)!.readings_button_inscription,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label:AppLocalizations.of(context)!.settings_button_inscription,
              ),
            ],
          ),
          floatingActionButton: tabRouter.activeIndex == 0
              ? _buildFloatingActionButton(context)
              : const SizedBox(),
        );
      },
    );
  }
}

FloatingActionButton _buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {},
    backgroundColor: AppColors.blueE,
    child: const Icon(
      Icons.add,
      color: AppColors.whiteFF,
    ),
  );
}