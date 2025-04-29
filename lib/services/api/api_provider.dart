import 'package:weather_app/services/api/weather/weather_api.dart';

class ApiProvider {
  ApiProvider._();

  static final ApiProvider instance = ApiProvider._();

  WeatherApi get weatherApi => WeatherApiImpl();
}
