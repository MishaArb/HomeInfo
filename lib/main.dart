import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_info/core/themes/app_theme.dart';
import 'package:home_info/presentation/bloc/locale/locale_bloc.dart';
import 'package:home_info/presentation/bloc/reminder/reminders/reminders_bloc.dart';
import 'package:home_info/presentation/bloc/theme/theme_bloc.dart';

import 'core/router/router.dart';
import 'injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  runApp(const HomeInfoApp());
}


class HomeInfoApp extends StatelessWidget {
  const HomeInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => getIt()..add(ThemeInitEvent()),
        ),
        BlocProvider<LocaleBloc>(
          create: (context) => getIt()..add(LocaleInitEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<RemindersBloc>()..add(RemindersFetchEvent()),
        ),
      ],
      child: Builder(
        builder: (context) {
          final themeState = context.select((ThemeBloc bloc) => bloc.state);
          final localeState = context.select((LocaleBloc bloc) => bloc.state);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localeState.currentLocale,
            title: 'HomeInfo',
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: themeState.currentTheme,
            routerConfig: getIt<AppRouter>().config(),
          );
        },
      ),
    );
  }
}
