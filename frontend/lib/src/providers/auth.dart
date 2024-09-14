import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/src/configs/constants/app_url.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;
  Map<String, dynamic>? _vendor;
  Map<String, dynamic>? get user => _vendor;
  final storage = FlutterSecureStorage();
  bool get authenticated => _authenticated;
  bool _obscureText = true;
  di.Dio dio = di.Dio();

  bool get obscureText => _obscureText;

  Future authentication({required Map credential}) async {
    try {
      di.Response response = await dio.post(
          "${AppUrl.baseUrl}${AppUrl.authentication}",
          data: json.encode(credential));
      String token = await response.data['access_token'];
      await getMe(token);
      await storeToken(token);
    } on di.DioError catch (e) {
      if (e.response?.statusCode == 422) {
        notifyListeners();
      }
      throw Exception(e.message);
    }
  }

  Future getMe(String? token) async {
    try {
      di.Response res = await dio.get(
        "${AppUrl.baseUrl}${AppUrl.me}",
        options: di.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      _vendor = res.data;

      _authenticated = true;
    } catch (e) {
      log('error log ${e.toString()}');
      _authenticated = false;
      throw Exception(e);
    } finally {
      notifyListeners();
    }
  }

  Future storeToken(String token) async {
    await storage.write(key: 'auth', value: token);
  }

  Future getToken() async {
    final token = await storage.read(key: 'auth');
    return token;
  }

  Future deleteToken() async {
    await storage.delete(key: 'auth');
  }

  Future logout() async {
    final token = await storage.read(key: 'auth');
    try {
      await dio.post("${AppUrl.baseUrl}${AppUrl.logout}",
          options: di.Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      _authenticated = false;
      await deleteToken();
    } catch (e) {
      throw Exception(e);
    } finally {
      notifyListeners();
    }
  }

  void toggleText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
