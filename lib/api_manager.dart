import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiManager {
  final Dio dio;
  final SharedPreferences prefs;

  ApiManager({
    required this.dio,
    required this.prefs,
  });

  Future<Response> posClientLogin() async {
    final posClientUrl = prefs.getString('branchposurl');
    final posUsername = prefs.getString('posusername');
    final posUserPassword = prefs.getString('posuserpassword');
    final dataToken = prefs.getString('posdatatoken');

    if (posClientUrl == null ||
        posClientUrl.isEmpty ||
        dataToken == null ||
        dataToken.isEmpty) {
      throw ApiException('Missing required parameters');
    }

    String url = '$posClientUrl/api/v1/login_api';
    String json =
        '{"username": "$posUsername", "password": "$posUserPassword"}';

    dio.options.headers = {'DATA_TOKEN': dataToken};
    dio.options.contentType = ("application/json");

    try {
      Response response = await dio.post(url, data: json);

      Map<String, dynamic> user = jsonDecode(response.toString());

      await prefs.setString('posclient_token', '${user['token']}');

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final user = jsonDecode(response.toString());
        await prefs.setString('posclient_token', '${user['token']}');
        return response;
      } else {
        throw ApiException(
            'Failed to login. Error code: ${response.statusCode}');
      }
    } catch (error) {
      throw ApiException(
          'Failed to login. Error message: ${handleError(error)}');
    }
  }

  String handleError(dynamic error) {
    String errorMessage = 'An error occurred';

    if (error is DioError) {
      if (error.response != null) {
        errorMessage = error.response!.data['message'];
      } else {
        errorMessage = error.message!;
      }
    }

    return errorMessage;
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}
