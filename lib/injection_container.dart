
import 'package:get_it/get_it.dart';

import 'core/router/router.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt() async{
  getIt.registerSingleton<AppRouter>(AppRouter());
}