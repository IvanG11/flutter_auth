import 'package:dio/dio.dart' as Dio;
import 'package:flutter_auth/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Auth extends ChangeNotifier {
  String token;
  bool authenticated = false;

  get loggedIn {
    return authenticated;
  }

  Future signin({Map data, Function success, Function error}) async {
    try {
      Dio.Response response =
          await dio().post('auth/signin', data: json.encode(data));

      String token = json.decode(response.toString())['data']['token'];

      this.attempt(token: token);

      notifyListeners();

      success();
    } catch (e) {
      error();
    }
  }

  void attempt({token = ''}) async {
    if (token.toString().isNotEmpty) {
      this.token = token;
    }

    if (token.toString().isEmpty) {
      return;
    }

    try {
      Dio.Response response = await dio().get('auth/me',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));

      this.authenticated = true;

      print(json.decode(response.toString())['data']);
    } catch (e) {
      this.authenticated = false;
    }
  }
}
