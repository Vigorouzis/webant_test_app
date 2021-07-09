import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:webant_test_app/data/datasources/shared_prefs.dart';
import 'package:webant_test_app/injection.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class SendImageApiProvider {
  Dio _dio = injection<Dio>();
  SharedPrefs _prefs = injection<SharedPrefs>();

  Future<String?> sendImageToApi({File? file,
    String? name,
    String? description,
    bool? newImage,
    bool? popularImage}) async {
    String fileName = file!
        .path
        .split('/')
        .last
        .substring(19);
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    var accessToken = await _prefs.read('access_token');
    accessToken = accessToken!.substring(1, accessToken.length - 1);

    var mediaObjectResponse = await _dio.post(
      "${ApiConstants.mediaObjectsURL}",
      data: formData,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      }),
    );

    if (mediaObjectResponse.statusCode == 201) {
      var params = {
        'image': '/api/media_objects/${mediaObjectResponse.data['id']}',
        'name': name,
        'description': description,
        'new': newImage,
        'popular': popularImage,
        'dateCreate': '-0001-11-30T00:00:00+02:31',
      };

      var response = await _dio.post(
        "${ApiConstants.imageURL}",
        data: jsonEncode(params),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        }),
      );
      if (response.statusCode == 201) {
        return 'OK';
      } else {
        return 'Not OK';
      }
    }else{
      return 'Not OK';
    }
  }
}
