class NetworkException implements Exception {
  final String request;
  final String errorName;
  final int errorCode;
  NetworkException({
    required this.request,
    required this.errorName,
    required this.errorCode,
  });

  @override
  String toString() {
    return "В запросе $request возникла ошибка $errorCode : $errorName";
  }
}
