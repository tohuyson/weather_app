import 'package:weather_app/services/api/weather/payload/get_weather_payload.dart';

import '../../base/base_endpoint.dart';
import '../../base/method_request.dart';

abstract class WeatherEndpointProtocol {
  EndpointType getCurrentWeather(GetWeatherPayload payload);

  EndpointType getForecastNextDays(GetWeatherPayload payload);
}

class WeatherEndpoint implements WeatherEndpointProtocol {
  @override
  EndpointType getCurrentWeather(GetWeatherPayload payload) {
    final endpoint = EndpointType(path: "/data/2.5/weather", httpMethod: HttpMethod.get, parameters: payload.toJson());
    return endpoint;
  }

  @override
  EndpointType getForecastNextDays(GetWeatherPayload payload) {
    final endpoint = EndpointType(path: "/data/2.5/forecast", httpMethod: HttpMethod.get, parameters: payload.toJson());
    return endpoint;
  }
}
