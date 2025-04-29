import 'package:weather_app/models/weather/current_weather_model.dart';

class NextDayWeatherModel {
  String? cod;
  int? message;
  int? cnt;
  List<NextDayWeatherItemModel>? list;
  CityModel? city;

  NextDayWeatherModel({this.cod, this.message, this.cnt, this.list, this.city});

  NextDayWeatherModel.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = <NextDayWeatherItemModel>[];
      json['list'].forEach((v) {
        list!.add(NextDayWeatherItemModel.fromJson(v));
      });
    }
    city = json['city'] != null ? CityModel.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}

class NextDayWeatherItemModel {
  DateTime? dt;
  MainModel? main;
  List<WeatherModel>? weather;
  CloudsModel? clouds;
  WindModel? wind;
  int? visibility;
  double? pop;
  SystemModel? sys;
  String? dtTxt;
  RainModel? rain;

  NextDayWeatherItemModel({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
    this.rain,
  });

  NextDayWeatherItemModel.fromJson(Map<String, dynamic> json) {
    dt = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    main = json['main'] != null ? MainModel.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = <WeatherModel>[];
      json['weather'].forEach((v) {
        weather!.add(WeatherModel.fromJson(v));
      });
    }
    clouds = json['clouds'] != null ? CloudsModel.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? WindModel.fromJson(json['wind']) : null;
    visibility = json['visibility'];
    pop = double.tryParse(json['pop'].toString());
    sys = json['sys'] != null ? SystemModel.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt'];
    rain = json['rain'] != null ? RainModel.fromJson(json['rain']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['dt'] = dt;
    if (main != null) {
      data['main'] = main!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    data['visibility'] = visibility;
    data['pop'] = pop;
    if (sys != null) {
      data['sys'] = sys!.toJson();
    }
    data['dt_txt'] = dtTxt;
    if (rain != null) {
      data['rain'] = rain!.toJson();
    }
    return data;
  }
}

class CityModel {
  int? id;
  String? name;
  CoordinateModel? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  CityModel({this.id, this.name, this.coord, this.country, this.population, this.timezone, this.sunrise, this.sunset});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? CoordinateModel.fromJson(json['coord']) : null;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    data['country'] = country;
    data['population'] = population;
    data['timezone'] = timezone;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
