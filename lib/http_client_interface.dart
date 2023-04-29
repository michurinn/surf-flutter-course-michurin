import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';

abstract class IHttpClient {
  Dio get dio => Dio();
}
