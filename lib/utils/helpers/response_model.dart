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
