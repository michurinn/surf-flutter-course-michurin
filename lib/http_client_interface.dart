import 'package:dio/dio.dart';

abstract class IHttpClient {
  Dio get dio => Dio();
}
