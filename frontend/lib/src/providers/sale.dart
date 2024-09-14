import 'package:dio/dio.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/src/configs/constants/app_url.dart';

class Sale extends ChangeNotifier {
  List<dynamic>? _sales;
  List<dynamic>? get sales => _sales;
  final storage = FlutterSecureStorage();
  di.Dio dio = di.Dio();

  Future list({Map<String, dynamic>? params}) async {
    try {
      final token = await storage.read(key: 'auth');
      di.Response response = await dio.get("${AppUrl.baseUrl}${AppUrl.sales}",
          options: di.Options(headers: {
            'Authorization': 'Bearer $token',
          }),
          queryParameters: params);
      _sales = response.data;
    } on di.DioError catch (e) {
      notifyListeners();
      throw Exception(e.message);
    }
  }
}
