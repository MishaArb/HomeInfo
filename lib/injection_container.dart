import 'package:get_it/get_it.dart';
import 'package:home_info/data/data_sources/shared_storage.service.dart';
import 'package:home_info/presentation/bloc/locale/locale_bloc.dart';
import 'package:home_info/presentation/bloc/reminder/new_reminder/new_reminder_bloc.dart';
import 'package:home_info/presentation/bloc/reminder/reminders/reminders_bloc.dart';
import 'package:home_info/presentation/bloc/theme/theme_bloc.dart';

import 'core/router/router.dart';
import 'data/data_sources/sqflite_db_service.dart';
import 'data/repository/reminder_db_repository.impl.dart';
import 'data/repository/storage_repository_impl.dart';
import 'domain/repository/reminder_db_repository.dart';
import 'domain/repository/storage_repository.dart';
import 'domain/usecase/reminder/new_reminder/save_reminder_usecase.dart';
import 'domain/usecase/reminder/reminders/delete_reminder_usecase.dart';
import 'domain/usecase/reminder/reminders/fetch_reminders_usecase.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerSingleton<AppRouter>(AppRouter());

  ///Database
  getIt.registerSingleton<SharedStorageService>(SharedStorageService());
  getIt.registerSingleton<SQfliteDBServices>(SQfliteDBServices());

 /// Repository
  getIt.registerSingleton<StorageRepository>(StorageRepositoryImpl(getIt()));
  getIt.registerSingleton<ReminderDBRepository>(ReminderDBRepositoryImpl(getIt()));

  /// UseCase
  getIt.registerSingleton<FetchRemindersUseCase>(FetchRemindersUseCase(getIt()));
  getIt.registerSingleton<SaveRemindersUseCase>(SaveRemindersUseCase(getIt()));
  getIt.registerSingleton<DeleteRemindersUseCase>(DeleteRemindersUseCase(getIt()));

  ///BLOC
  getIt.registerFactory<ThemeBloc>(() => ThemeBloc(getIt()));
  getIt.registerFactory<LocaleBloc>(() => LocaleBloc(getIt()));
  getIt.registerFactory<RemindersBloc>(() => RemindersBloc(getIt(), getIt()));
  getIt.registerFactory<NewReminderBloc>(() => NewReminderBloc(getIt()));
}
