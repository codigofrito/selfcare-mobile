import 'package:dio/dio.dart';

abstract class GraphApiProvider {
  static final options = BaseOptions(
    baseUrl: 'https://graph.facebook.com',
    contentType: 'application/json',
    connectTimeout: 90000,
    receiveTimeout: 90000,
  );

  static final public = Dio(options);  

}
