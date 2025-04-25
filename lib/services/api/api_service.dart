import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_app/common/utils/log_util.dart';
import 'package:weather_app/common/utils/network_util.dart';
import 'package:weather_app/env_data.dart';
import 'package:weather_app/services/base/base_endpoint.dart';
import 'package:weather_app/services/base/base_response.dart';
import 'package:weather_app/services/base/method_request.dart';

abstract class APIServiceProtocol {
  Future<BaseResponse> requestData(EndpointType endpoint);
}

class APIService extends APIServiceProtocol {
  final _tag = "APIService";

  APIService._();

  static final APIService instance = APIService._();

  Dio? dio;

  Dio init() {
    if (dio == null) {
      dio = Dio();
      dio!.options.baseUrl = EnvData.instance.baseUrl;
    }
    return dio!;
  }

  Future<BaseResponse> _handler(Dio dio, Map<String, dynamic> header, EndpointType endpoint) async {
    Response response;
    bool isGETMethod = endpoint.httpMethod == HttpMethod.get;

    try {
      response = await dio.request(
        endpoint.path!,
        data: isGETMethod ? null : endpoint.parameters,
        queryParameters: isGETMethod ? endpoint.parameters : null,
        options: Options(
          headers: header.isEmpty ? DefaultHeader.instance.addDefaultHeader() : header,
          contentType: Headers.jsonContentType,
          method: endpoint.httpMethod!.getValue(),
          sendTimeout: const Duration(seconds: 120),
          receiveTimeout: const Duration(seconds: 120),
        ),
      );
    } catch (error) {
      AppLog.d(_tag, "----------------------start-error-response-------------------");
      AppLog.d(_tag, 'method: ${endpoint.httpMethod?.getValue()}');
      AppLog.d(_tag, 'path: ${endpoint.path}');
      AppLog.d(_tag, 'param: ${jsonEncode(endpoint.parameters)}');
      AppLog.d(_tag, 'response: ${error is DioException ? error.response?.statusMessage : error.toString()}');
      AppLog.d(_tag, "----------------------end-error-response-------------------");

      String errorMessage = 'Error occurred';
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.connectionError:
            errorMessage = "Not connected to the internet";
            break;
          case DioExceptionType.unknown:
          default:
            break;
        }
      }

      return BaseResponse(status: false, errorMessage: errorMessage);
    }

    final json = (response.data is Map<String, dynamic>) ? response.data : jsonDecode(response.data.toString());
    AppLog.d(_tag, "----------------------start-response-------------------");
    if (endpoint.httpMethod == HttpMethod.get) {
      AppLog.d(_tag, 'uri: ${response.realUri}');
    }
    AppLog.d(_tag, 'method: ${endpoint.httpMethod?.getValue()}');
    AppLog.d(_tag, 'path: ${endpoint.path}');
    AppLog.d(_tag, 'param: ${jsonEncode(endpoint.parameters)}');
    AppLog.d(_tag, 'response: ${jsonEncode(json)}');
    AppLog.d(_tag, "----------------------end-response-------------------");
    if (response.statusCode == 200) {
      return BaseResponse(status: true, data: json);
    } else {
      return BaseResponse(status: false, data: json);
    }
  }

  @override
  Future<BaseResponse> requestData(EndpointType endpoint) async {
    Dio dio = init();
    final isNetworkAvailable = await NetworkUtil.instance.checkConnection();
    if (!isNetworkAvailable) {
      return BaseResponse(status: false, errorMessage: 'No internet connection');
    }

    final header = <String, dynamic>{};

    return await _handler(dio, header, endpoint);
  }
}
