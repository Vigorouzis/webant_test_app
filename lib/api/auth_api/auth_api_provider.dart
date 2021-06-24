import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:webant_test_app/api/shared_prefs.dart';
import 'package:webant_test_app/locator.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class AuthApiProvider {
  Dio _dio = locator.get<Dio>();
  var _prefs = locator.get<SharedPrefs>();

  Future<String?> authorization({
    String? username,
    String? password,
  }) async {
    String? clientSecret;
    String? clientRandomId;

    String? clientId = await _prefs.read('client_id');

    var data =
        await _dio.get('http://gallery.dev.webant.ru/api/clients/$clientId');

    if (data.statusCode == 200) {
      clientRandomId = data.data['randomId'];
      clientSecret = data.data['secret'];
    }

    Response response = await _dio.get(
      '${ApiConstants.tokenURL}?client_id=${clientId}_$clientRandomId&grant_type=password&username=$username&password=$password&client_secret=$clientSecret',
      options: Options(
        contentType: 'application/json',
      ),
    );

    if (response.statusCode == 200) {
      await _prefs.save('access_token', response.data['access_token']);
      await _prefs.save('refresh_token', response.data['refresh_token']);
      return 'OK';
    } else {
      return 'Not OK';
    }
  }

  Future<String> registrationNewUser({
    String? fullName,
    String? birthday,
    String? email,
    String? password,
    String? username,
    String? phone,
  }) async {
    var params = {
      'email': email,
      'fullName': fullName,
      'password': password,
      'birthday': birthday,
      'username': username,
      'phone': phone,
    };

    Response response = await _dio.post(
      ApiConstants.singUpURL,
      data: jsonEncode(params),
      options: Options(
        contentType: 'application/json',
      ),
    );

    if (response.statusCode == 201) {
      await _prefs.save('client_id', response.data['id']);
      return 'OK';
    } else {
      return 'Not OK';
    }
  }
}
