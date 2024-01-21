import 'package:auto_route/auto_route.dart';

import '../../presentation/pages/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../presentation/pages/home/home_screen.dart';
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
          ],
        ),
        AutoRoute(page: RemindersRoute.page, path: '/remindersScreen'),
        AutoRoute(page: ThemeRoute.page, path: '/themeScreen'),
        AutoRoute(page: LanguageRoute.page, path: '/languageScreen'),
      ];
}
