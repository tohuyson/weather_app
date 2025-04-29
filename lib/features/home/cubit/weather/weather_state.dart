part of 'weather_cubit.dart';

class WeatherState extends Equatable {
  const WeatherState({this.status = BlocStatus.initial, this.currentWeather, this.averageTempNextFourDays = const {}});

  final BlocStatus status;
  final CurrentWeatherModel? currentWeather;
  final Map<DateTime, String> averageTempNextFourDays;

  @override
  List<Object?> get props => [status, currentWeather, averageTempNextFourDays];

  WeatherState copyWith({
    BlocStatus? status,
    CurrentWeatherModel? currentWeather,
    Map<DateTime, String>? averageTempNextFourDays,
  }) {
    return WeatherState(
      status: status ?? this.status,
      currentWeather: currentWeather ?? this.currentWeather,
      averageTempNextFourDays: averageTempNextFourDays ?? this.averageTempNextFourDays,
    );
  }
}
