import 'package:dio/dio.dart' as Dio;
import 'package:flutter_auth/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'User.dart';

class Auth extends ChangeNotifier {
  final storage = new FlutterSecureStorage();

  String token;
  bool authenticated = false;
  User authenticatedUser;

  get loggedIn {
    return authenticated;
  }

  get user {
    return authenticatedUser;
  }

  Future signin({Map data, Function success, Function error}) async {
    try {
      Dio.Response response =
          await dio().post('auth/signin', data: json.encode(data));

      String token = json.decode(response.toString())['data']['token'];

      this._setStoredToken(token);
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
      Dio.Response response = await dio().get('auth/me');

      this.authenticated = true;

      this.authenticatedUser =
          User.fromJson(json.decode(response.toString())['data']);

      notifyListeners();
    } catch (e) {
      this._setUnauthenticated();
    }
  }

  void signout({Function success}) async {
    try {
      await dio().post('auth/signout');

      this._setUnauthenticated();
      notifyListeners();

      success();
    } catch (e) {
      //
    }
  }

  void _setUnauthenticated() async {
    this.authenticated = false;
    this.authenticatedUser = null;

    await storage.delete(key: 'token');
  }

  void _setStoredToken(String token) async {
    await storage.write(key: 'token', value: token);
  }
}
