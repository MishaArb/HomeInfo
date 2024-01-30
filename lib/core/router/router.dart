import 'package:auto_route/auto_route.dart';

import '../../presentation/pages/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../presentation/pages/create_or_edit_reading/create_or_edit_reading_screen.dart';
import '../../presentation/pages/create_or_edit_reading/services/services_screen.dart';
import '../../presentation/pages/home/home_screen.dart';
import '../../presentation/pages/readings/readings_screen.dart';
import '../../presentation/pages/readings/search_reading_screen.dart';
import '../../presentation/pages/settings/language/language_screen.dart';
import '../../presentation/pages/settings/reminder/reminders_screen.dart';
import '../../presentation/pages/settings/settings_screen.dart';
import '../../presentation/pages/settings/theme/theme_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: BottomNavigationBarRoute.page,
          initial: true,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: SettingsRoute.page),
            AutoRoute(page: ReadingsRoute.page),
          ],
        ),
        AutoRoute(page: RemindersRoute.page, path: '/remindersScreen'),
        AutoRoute(page: ThemeRoute.page, path: '/themeScreen'),
        AutoRoute(page: LanguageRoute.page, path: '/languageScreen'),
        AutoRoute(page: SearchReadingRoute.page, path: '/searchReadingScreen'),
        AutoRoute(page: CreateOrEditReadingsRoute.page, path: '/createOrEditReadingsScreen'),
        AutoRoute(page: ServicesRoute.page, path: '/servicesScreen'),
      ];
}
