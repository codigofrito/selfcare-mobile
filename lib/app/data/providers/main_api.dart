import 'package:dio/dio.dart';

abstract class MainApiProvider {
  static final options = BaseOptions(
    baseUrl: 'http://api-selfcare.machado.codes',
    contentType: 'application/json; charset=utf-8',
    responseType: ResponseType.plain,
    connectTimeout: 90000,
    receiveTimeout: 90000,
  );

  static final public = Dio(options);

  static final private = Dio(options)
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions) async {
          String oAuthToken = "true";
          requestOptions.headers.addAll({
            'oauth': '$oAuthToken',
          });
          return requestOptions;
        },
      ),
    );
}
