class GetWeatherPayload {
  double? latitude;
  double? longitude;
  String? lang;
  String? appId;
  String? units;

  GetWeatherPayload({this.latitude, this.longitude, this.lang, this.appId, this.units});
  Map<String, dynamic> toJson() {
    return {'lat': latitude, 'lon': longitude, 'lang': lang ?? 'vi', 'appid': appId, 'units': units ?? 'metric'};
  }
}
