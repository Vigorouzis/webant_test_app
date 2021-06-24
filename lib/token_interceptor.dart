import 'dart:io';

import 'package:dio/dio.dart';
import 'package:webant_test_app/api/shared_prefs.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class TokenInterceptor extends Interceptor {
  final Dio? dio;

  final SharedPrefs? preferences;

  TokenInterceptor({required this.dio, required this.preferences});

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var tokensEntity = await preferences!.read('access_token');
    if (tokensEntity.isNotEmpty) {
      options.headers = {
        HttpHeaders.authorizationHeader: 'Bearer ${tokensEntity.accessToken}'
      };
    }

    return options;
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if ((err.error as String).contains('401') ?? false) {
      String? refreshToken = await preferences!.read('refresh_token');
      String? clientId = await preferences!.read('client_id');
      String? clientSecret;
      String? clientRandomId;

      var data =
          await dio!.get('http://gallery.dev.webant.ru/api/clients/$clientId');
      if (data.statusCode == 200) {
        clientRandomId = data.data['randomId'];
        clientSecret = data.data['secret'];
      }

      print('${err.requestOptions.path} refresh token $refreshToken ');

      if (refreshToken != null) {
        return dio!.request(
          '${ApiConstants.tokenURL}?client_id=${clientId}_$clientRandomId&grant_type=refresh_token&refresh_token=$refreshToken&client_secret=$clientSecret',
          cancelToken: err.requestOptions.cancelToken,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          onReceiveProgress: err.requestOptions.onReceiveProgress,
          onSendProgress: err.requestOptions.onSendProgress,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $refreshToken'
          }, method: 'GET'),
        );
      } else {
        return err;
      }
    } else {
      return err;
    }
  }
}
