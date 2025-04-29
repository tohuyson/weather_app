import 'package:weather_app/models/base_model.dart';
import 'package:weather_app/models/weather/current_weather_model.dart';
import 'package:weather_app/models/weather/next_day_weather_model.dart';
import 'package:weather_app/services/api/api_provider.dart';
import 'package:weather_app/services/api/weather/payload/get_weather_payload.dart';

class WeatherRepository {
  Future<BaseModel<CurrentWeatherModel>> getCurrentWeather(GetWeatherPayload payload) {
    return ApiProvider.instance.weatherApi.getCurrentWeather(payload);
  }

  Future<BaseModel<NextDayWeatherModel>> getForecastNextDays(GetWeatherPayload payload) {
    return ApiProvider.instance.weatherApi.getForecastNextDays(payload);
  }
}
