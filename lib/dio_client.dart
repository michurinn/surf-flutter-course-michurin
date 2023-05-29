
import 'package:dio/dio.dart';
import 'package:places/http_client_interface.dart';

class DioClient implements IHttpClient {
  DioClient();

  @override
  final Dio dio = Dio(BaseOptions())
    ..options.baseUrl =
        'https://test-backend-flutter.surfstudio.ru/'
    ..options.connectTimeout = const Duration(milliseconds: 5000)
    ..options.receiveTimeout = const Duration(milliseconds: 5000)
    ..options.sendTimeout = const Duration(milliseconds: 5000)
    ..options.responseType = ResponseType.json
    ..interceptors.add(LogInterceptor(requestBody: false, responseHeader: false, responseBody: false));

  void testGet() async {
    var d = Dio()
      ..options.baseUrl = 'https://jsonplaceholder.typicode.com/'
      ..options.responseType = ResponseType.json
      ..interceptors.add(LogInterceptor(
          requestBody: true, responseHeader: false, responseBody: true));
    await d.get('/users');
  }

}
