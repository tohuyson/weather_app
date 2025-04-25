import 'method_request.dart';

class EndpointType {
  EndpointType({this.path, this.httpMethod, this.parameters, this.header = const {}});

  String? path;
  HttpMethod? httpMethod;
  Map<String, dynamic>? parameters;
  Map<String, String> header;
}

class DefaultHeader {
  DefaultHeader._();

  static final DefaultHeader instance = DefaultHeader._();

  Map<String, String> addDefaultHeader() {
    Map<String, String> header = <String, String>{};
    header["Content-Type"] = "application/json";
    return header;
  }
}
