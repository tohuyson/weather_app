class BaseResponse {
  final bool? status;
  final String? errorTitle;
  final String? errorMessage;
  final String? errorCode;
  final dynamic data;

  BaseResponse({this.status, this.errorTitle, this.errorMessage, this.errorCode, this.data});
}
