import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:webant_test_app/data/datasources/shared_prefs.dart';
import 'package:webant_test_app/domain/repositories/user_repository.dart';
import 'package:webant_test_app/injection.dart';
import 'package:webant_test_app/data/models/user.dart';

import 'package:webant_test_app/utils/api_constants.dart';

class UserRepositoryImpl implements UserRepository {
  var _dio = injection.get<Dio>();
  var _prefs = injection.get<SharedPrefs>();

  Future<User?> getProfileInfo() async {
    var clientId = await _prefs.read('client_id');
    var response = await _dio.get('${ApiConstants.profileURL}/$clientId');
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw Exception('Failed load user');
    }
  }

  Future<User?> sendDataToApi({
    String? username,
    DateTime? birthday,
    String? email,
    String? phone,
    String? fullName,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
  }) async {
    var clientId = await _prefs.read('client_id');
    var accessToken = await _prefs.read('access_token');
    accessToken = accessToken.substring(1, accessToken.length - 1);
    var params = {
      'email': email,
      'phone': phone,
      'fullName': fullName,
      'username': username,
      'birthday': birthday,
    };

    Response? changePasswordResponse;
    Response? response;
    if (oldPassword!.isNotEmpty && newPassword!.isNotEmpty) {
      changePasswordResponse = await changePassword(
          clientId: clientId,
          accessToken: accessToken,
          newPassword: newPassword,
          oldPassword: oldPassword);
      response = await _dio.put(
        '${ApiConstants.profileURL}/$clientId',
        data: jsonEncode(params),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        }),
      );
    } else {
      response = await _dio.put(
        '${ApiConstants.profileURL}/$clientId',
        data: jsonEncode(params),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        }),
      );
    }
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<List<String?>?> getUploadImagesFromUser() async {
    List<String?> _imageList = [];
    var response = await _dio.get(
        '${ApiConstants.imageURL}?new=true&popular=false&user.id=386&limit=500');
    if (response.statusCode == 200) {
      if (response.data['totalItems'] == 0) {
        return _imageList;
      }
      for (var i = 0; i < response.data['totalItems']; i++) {
        _imageList.add(response.data['data'][i]['image']['name']);
      }

      return _imageList;
    } else {
      throw Exception('Failed load user');
    }
  }

  @override
  Future<Response?>? changePassword({
    String? oldPassword,
    String? newPassword,
    String? accessToken,
    String? clientId,
  }) async {
    var params = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };

    var response = await _dio.put(
      '${ApiConstants.changePasswordURL}/$clientId',
      data: jsonEncode(params),
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      }),
    );
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }
}
