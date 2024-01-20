import 'package:get_it/get_it.dart';
import 'package:home_info/data/data_sources/shared_storage.service.dart';
import 'package:home_info/presentation/bloc/locale/locale_bloc.dart';
import 'package:home_info/presentation/bloc/theme/theme_bloc.dart';

import 'core/router/router.dart';
import 'data/repository/storage_repository_impl.dart';
import 'domain/repository/storage_repository.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerSingleton<AppRouter>(AppRouter());

  ///SHARED
  getIt.registerSingleton<SharedStorageService>(SharedStorageService());
  getIt.registerSingleton<StorageRepository>(
      StorageRepositoryImpl(getIt()));

  ///BLOC
  getIt.registerFactory<ThemeBloc>(() => ThemeBloc(getIt()));
  getIt.registerFactory<LocaleBloc>(() => LocaleBloc(getIt()));
}
