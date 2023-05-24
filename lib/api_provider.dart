import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._internal();

  factory ApiProvider() => _instance;

  Dio? dio;
  SharedPreferences? sharedPreferences;

  ApiProvider._internal();

  Future<ApiProvider> init() async {
    dio = Dio();
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}
