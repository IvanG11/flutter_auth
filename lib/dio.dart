import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

Dio dio() {
  Dio dio = new Dio();

  dio.options.baseUrl = 'http://5b7b4bb4.ngrok.io/api/';

  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
    options.headers['Accept'] = 'application/json';

    var token = await storage.read(key: 'token');

    if (token.toString().isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }));

  return dio;
}
