import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();

  dio.options.baseUrl = 'http://92f2b840.ngrok.io/api/';

  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
    options.headers['Accept'] = 'application/json';
  }));

  return dio;
}
