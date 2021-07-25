import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:webant_test_app/data/datasources/gateway.dart';
import 'package:webant_test_app/data/datasources/server_not_responding.dart';
import 'package:webant_test_app/data/datasources/shared_prefs.dart';
import 'package:webant_test_app/domain/repositories/auth_repository.dart';

import 'package:webant_test_app/injection.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class AuthRepositoryImpl implements AuthRepository {
  Dio _dio = injection.get<Dio>();
  var _prefs = injection.get<SharedPrefs>();
  Gateway _gateway = injection<Gateway>();

  @override
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
      _gateway.setAccessToken(value: response.data['access_token']);
      _gateway.setRefreshToken(value: response.data['refresh_token']);
      return 'OK';
    } else {
      return 'Not OK';
    }
  }

  @override
  Future<String> registrationNewUser({
    String? fullName,
    String? birthday,
    String? email,
    String? password,
    String? username,
    String? phone,
  }) async {
    var date = birthday!.isEmpty ? null : birthday;

    var params = {
      'email': email,
      'fullName': fullName,
      'password': password,
      'birthday': date,
      'username': username,
      'phone': phone,
    };
    Response response;
    try {
      response = await _dio.post(
        ApiConstants.singUpURL,
        data: jsonEncode(params),
        options: Options(
          contentType: 'application/json',
        ),
      );

      if (response.statusCode == 400 || response.statusCode == 404) {
        throw ServerNorResponding(message: response.data['detail']);
      }

      if (response.statusCode == 201) {
        _gateway.setClientId(value: response.data['id']);
        return 'OK';
      } else {
        return 'Not OK';
      }
    } catch (_) {
      throw ServerNorResponding(message: 'Error');
    }
  }
}
