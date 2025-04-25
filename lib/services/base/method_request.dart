enum HttpMethod {
  get,
  post,
  put,
  delete,
  patch
}

extension ValueHttpMethod on HttpMethod {
  String getValue() {
    switch (index) {
      case 0:
        return "GET";
      case 1:
        return "POST";
      case 2:
        return "PUT";
      case 3:
        return "DELETE";
      case 4:
        return "PATCH";
    }
    return "";
  }
}