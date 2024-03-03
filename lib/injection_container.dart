import 'package:get_it/get_it.dart';
import 'package:home_info/data/data_sources/shared_storage.service.dart';
import 'package:home_info/data/repository/home_services_db_repository_impl.dart';
import 'package:home_info/presentation/bloc/chart/chart_bloc.dart';
import 'package:home_info/presentation/bloc/home_service/home_services/home_services_bloc.dart';
import 'package:home_info/presentation/bloc/home_service/new_home_service/new_home_service_bloc.dart';
import 'package:home_info/presentation/bloc/locale/locale_bloc.dart';
import 'package:home_info/presentation/bloc/reading/new_reading/new_reading_bloc.dart';
import 'package:home_info/presentation/bloc/reading/readings/readings_bloc.dart';
import 'package:home_info/presentation/bloc/reminder/new_reminder/new_reminder_bloc.dart';
import 'package:home_info/presentation/bloc/reminder/reminders/reminders_bloc.dart';
import 'package:home_info/presentation/bloc/theme/theme_bloc.dart';

import 'core/router/router.dart';
import 'data/data_sources/sqflite_db.dart';
import 'data/repository/local_notification_repository_imp.dart';
import 'data/repository/reading_db_repository.impl.dart';
import 'data/repository/reminder_db_repository.impl.dart';
import 'data/repository/storage_repository_impl.dart';
import 'data/services/local_notification_services.dart';
import 'domain/repository/home_services_db_repository.dart';
import 'domain/repository/local_notification_repository.dart';
import 'domain/repository/reading_db_repository.dart';
import 'domain/repository/reminder_db_repository.dart';
import 'domain/repository/storage_repository.dart';
import 'domain/usecase/delete_home_service_usercase.dart';
import 'domain/usecase/delete_local_notification_usecase.dart';
import 'domain/usecase/delete_reading_usercase.dart';
import 'domain/usecase/fetch_home_service_usercase.dart';
import 'domain/usecase/fetch_readings_usercase.dart';
import 'domain/usecase/save_home_service_usercase.dart';
import 'domain/usecase/save_reading_usercase.dart';
import 'domain/usecase/set_local_notification_usecase.dart';
import 'domain/usecase/save_reminder_usecase.dart';
import 'domain/usecase/delete_reminder_usecase.dart';
import 'domain/usecase/fetch_reminders_usecase.dart';
import 'domain/usecase/update_reading_usercase.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerSingleton<AppRouter>(AppRouter());

  ///Database
  getIt.registerSingleton<SharedStorageService>(SharedStorageService());
  getIt.registerSingleton<SQfliteDB>(SQfliteDB());

  ///Services
  getIt.registerSingleton<LocalNotificationService>(LocalNotificationService());

 /// Repository
  getIt.registerSingleton<StorageRepository>(StorageRepositoryImpl(getIt()));
  getIt.registerSingleton<ReminderDBRepository>(ReminderDBRepositoryImpl(getIt()));
  getIt.registerSingleton<LocalNotificationRepository>(LocalNotificationRepositoryImpl(getIt()));
  getIt.registerSingleton<HomeServicesDBRepository>(HomeServicesDBRepositoryImpl(getIt()));
  getIt.registerSingleton<ReadingDBRepository>(ReadingDBRepositoryImpl(getIt()));

  /// UseCase
  getIt.registerSingleton<FetchRemindersUseCase>(FetchRemindersUseCase(getIt()));
  getIt.registerSingleton<SaveReminderUseCase>(SaveReminderUseCase(getIt()));
  getIt.registerSingleton<DeleteRemindersUseCase>(DeleteRemindersUseCase(getIt()));
  getIt.registerSingleton<SetLocalNotificationUseCase>(SetLocalNotificationUseCase(getIt()));
  getIt.registerSingleton<DeleteLocalNotificationUseCase>(DeleteLocalNotificationUseCase(getIt()));
  getIt.registerSingleton<SaveHomeServiceUseCase>(SaveHomeServiceUseCase(getIt()));
  getIt.registerSingleton<DeleteHomeServiceUseCase>(DeleteHomeServiceUseCase(getIt()));
  getIt.registerSingleton<FetchHomeServicesUseCase>(FetchHomeServicesUseCase(getIt()));
  getIt.registerSingleton<CreateReadingUseCase>(CreateReadingUseCase(getIt()));
  getIt.registerSingleton<UpdateReadingUseCase>(UpdateReadingUseCase(getIt()));
  getIt.registerSingleton<FetchReadingsUseCase>(FetchReadingsUseCase(getIt()));
  getIt.registerSingleton<DeleteReadingUseCase>(DeleteReadingUseCase(getIt()));

  ///BLOC
  getIt.registerFactory<ThemeBloc>(() => ThemeBloc(getIt()));
  getIt.registerFactory<LocaleBloc>(() => LocaleBloc(getIt()));
  getIt.registerFactory<RemindersBloc>(() => RemindersBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory<NewReminderBloc>(() => NewReminderBloc(getIt(), getIt()));
  getIt.registerFactory<NewHomeServiceBloc>(() => NewHomeServiceBloc(getIt()));
  getIt.registerFactory<HomeServicesBloc>(() => HomeServicesBloc(getIt(),getIt()));
  getIt.registerFactory<NewReadingBloc>(() => NewReadingBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory<ReadingsBloc>(() => ReadingsBloc(getIt(),getIt()));
  getIt.registerFactory<ChartBloc>(() => ChartBloc(getIt(), getIt()));
}
