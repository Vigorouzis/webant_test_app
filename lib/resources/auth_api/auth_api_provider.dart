import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class AuthApiProvider {
  Dio _dio = Dio();

  Future<String> authorization({
    String? username,
    String? password,
  }) async {
    var clientSecret = await getClientSecret();
    var clientRandomId = await getRandomId();

    Response response = await _dio.get(
      '${ApiConstants.singInURL}?client_id=386_$clientRandomId&grant_type=password&username=$username&password=$password&client_secret=$clientSecret',
      options: Options(
        contentType: 'application/json',
      ),
    );

    if (response.statusCode == 200) {
      return 'OK';
    } else {
      return 'Not OK';
    }
  }

  Future<String?> getClientSecret() async {
    var response =
        await _dio.get('http://gallery.dev.webant.ru/api/clients/386');

    if (response.statusCode == 200) {
      return response.data['secret'];
    }
    return null;
  }

  Future<String?> getRandomId() async {
    var response =
        await _dio.get('http://gallery.dev.webant.ru/api/clients/386');

    if (response.statusCode == 200) {
      return response.data['randomId'];
    }
    return null;
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

    if (response.statusCode == 200) {
      // (await SharedPreferences.getInstance()).setString('client_id', response.d)
      return 'OK';
    } else {
      return 'Not OK';
    }
  }
}
