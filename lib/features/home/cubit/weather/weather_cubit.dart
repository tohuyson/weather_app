import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/common/bloc_status.dart';
import 'package:weather_app/common/utils/location_util.dart';
import 'package:weather_app/env_data.dart';
import 'package:weather_app/features/home/repository/weather_repository.dart';
import 'package:weather_app/models/weather/current_weather_model.dart';
import 'package:weather_app/models/weather/next_day_weather_model.dart';
import 'package:weather_app/services/api/weather/payload/get_weather_payload.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherState());

  final WeatherRepository _weatherRepository = WeatherRepository();

  initFetchData({bool isLoading = true}) async {
    if (isLoading) {
      emit(state.copyWith(status: BlocStatus.loading));
    }
    Position? currentLocation = await LocationUtil.instance.getCurrentLocation();
    String apiKey = EnvData.instance.apiKey;

    if (currentLocation == null) {
      emit(state.copyWith(status: BlocStatus.failure));
      return;
    }
    final result = await Future.wait([
      getCurrentWeather(currentLocation.latitude, currentLocation.longitude, apiKey),
      getForecastNextDays(currentLocation.latitude, currentLocation.longitude, apiKey),
    ]);
    if (result[0] == null || result[1] == null) {
      emit(state.copyWith(status: BlocStatus.failure));
      return;
    }
    emit(state.copyWith(status: BlocStatus.success, currentWeather: result[0], averageTempNextFourDays: result[1]));
  }

  Future getCurrentWeather(double latitude, double longitude, String apiKey) async {
    final result = await _weatherRepository.getCurrentWeather(
      GetWeatherPayload(latitude: latitude, longitude: longitude, appId: apiKey),
    );

    return result.data;
  }

  Future getForecastNextDays(double latitude, double longitude, String apiKey) async {
    final result = await _weatherRepository.getForecastNextDays(
      GetWeatherPayload(latitude: latitude, longitude: longitude, appId: apiKey),
    );

    final List<NextDayWeatherItemModel>? data = result.data?.list;

    return averageTemperatureNextFourDays(groupDateByDateWithoutToday(data));
  }

  groupDateByDateWithoutToday(List<NextDayWeatherItemModel>? data) {
    if (data == null) return;

    final now = DateUtils.dateOnly(DateTime.now());

    Map<DateTime, List<NextDayWeatherItemModel>> groupedData = {};

    for (var item in data) {
      final date = DateUtils.dateOnly(item.dt ?? now);

      if (date.isAtSameMomentAs(now) || date.isBefore(now)) continue;

      if (groupedData[date] == null) {
        groupedData[date] = [item];
      } else {
        groupedData[date]!.add(item);
      }
    }

    return groupedData;
  }

  averageTemperatureNextFourDays(Map<DateTime, List<NextDayWeatherItemModel>> groupedData) {
    if (groupedData.isEmpty) return 0.0;

    Map<DateTime, String> averageTempNextFourDays = {};

    groupedData.forEach((date, items) {
      final avgTemp = (items.map((e) => e.main?.temp).reduce((a, b) => (a ?? 0) + (b ?? 0)) ?? 0) / items.length;
      averageTempNextFourDays[date] = avgTemp.toStringAsFixed(2);
    });

    return averageTempNextFourDays;
  }
}
