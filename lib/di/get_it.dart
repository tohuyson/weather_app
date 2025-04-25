import 'package:get_it/get_it.dart';
import 'package:weather_app/features/app_cubit.dart';

import '../routes/routes.dart';

final getItInstance = GetIt.I;

configureDependencies() {
  getItInstance.registerSingleton<AppRouter>(AppRouter());
  getItInstance.registerSingleton<AppCubit>(AppCubit());
}
