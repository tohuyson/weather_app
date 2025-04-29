import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/app_data.dart';
import 'package:weather_app/common/bloc_status.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  init() async {
    emit(state.copyWith(status: BlocStatus.loading));
    await initializeDateFormatting('vi');
    await Future.wait([
      AppData.instance.getDeviceInfo(),
      Future.delayed(const Duration(seconds: 2)), // delay for splash screen]
    ]);
    emit(state.copyWith(status: BlocStatus.success));
  }
}
