class ResponseModel<T> {
  String statusCode;
  String statusMessage;
  T? data;
  ResponseModel({
    required this.statusCode,
    required this.statusMessage,
    this.data,
  });
}

class TrendingNowResponseModel<T> {
  String statusCode;
  String statusMessage;
  T? data;
  TrendingNowResponseModel({
    required this.statusCode,
    required this.statusMessage,
    this.data,
  });
}

class NewReleasesResponseModel<T> {
  String statusCode;
  String statusMessage;
  T? data;
  NewReleasesResponseModel({
    required this.statusCode,
    required this.statusMessage,
    this.data,
  });
}
