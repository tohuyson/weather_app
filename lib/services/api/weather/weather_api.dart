import 'package:weather_app/models/weather/current_weather_model.dart';
import 'package:weather_app/models/weather/next_day_weather_model.dart';
import 'package:weather_app/services/api/weather/payload/get_weather_payload.dart';
import 'package:weather_app/services/api/weather/weather_endpoint.dart';

import '../../../models/base_model.dart';
import '../../base/base_response.dart';
import '../api_service.dart';

abstract class WeatherApi {
  Future<BaseModel<CurrentWeatherModel>> getCurrentWeather(GetWeatherPayload payload);

  Future<BaseModel<NextDayWeatherModel>> getForecastNextDays(GetWeatherPayload payload);
}

class WeatherApiImpl implements WeatherApi {
  @override
  Future<BaseModel<CurrentWeatherModel>> getCurrentWeather(GetWeatherPayload payload) async {
    BaseResponse apiResponse = await APIService.instance.requestData(WeatherEndpoint().getCurrentWeather(payload));
    if (apiResponse.status == true) {
      return BaseModel<CurrentWeatherModel>(status: true, data: CurrentWeatherModel.fromJson(apiResponse.data));
    } else {
      return BaseModel<CurrentWeatherModel>(
        status: false,
        errorCode: apiResponse.errorCode,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<NextDayWeatherModel>> getForecastNextDays(GetWeatherPayload payload) async {
    BaseResponse apiResponse = await APIService.instance.requestData(WeatherEndpoint().getForecastNextDays(payload));
    if (apiResponse.status == true) {
      return BaseModel<NextDayWeatherModel>(status: true, data: NextDayWeatherModel.fromJson(apiResponse.data));
    } else {
      return BaseModel<NextDayWeatherModel>(
        status: false,
        errorCode: apiResponse.errorCode,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }
}
