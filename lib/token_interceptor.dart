import 'dart:io';

import 'package:dio/dio.dart';

import 'package:webant_test_app/data/datasources/shared_prefs.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class TokenInterceptor extends Interceptor {
  final Dio? dio;

  final SharedPrefs? preferences;

  TokenInterceptor({required this.dio, required this.preferences});

  // @override
  // Future onRequest(
  //     RequestOptions options, RequestInterceptorHandler handler) async {
  //   var tokensEntity = await preferences!.read('access_token');
  //   print('REQUEST[${options.method}] => PATH: ${options.path}');
  //
  //   if (tokensEntity.isNotEmpty) {
  //     options.path =
  //         '${ApiConstants.imageURL}?new=true&popular=false&&limit=10';
  //     options.headers = {
  //       HttpHeaders.authorizationHeader: 'Bearer $tokensEntity'
  //     };
  //   }
  //
  //   return options;
  // }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response!.statusCode == 401) {
      String? refreshToken = await preferences?.read('refresh_token');
      //refreshToken = refreshToken?.substring(1, refreshToken.length - 1);
      // print(refreshToken);
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
        var response = await dio!.request(
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

        var accessToken = response.data['access_token'] as String;
        accessToken = accessToken.substring(1, accessToken.length - 1);
        var refToken = response.data['refresh_token'] as String;
        refToken = refToken.substring(1, refreshToken.length - 1);

        await preferences!.save('access_token', accessToken);
        await preferences!
            .save('refresh_token', refToken);
      } else {
        return err;
      }
    } else {
      return err;
    }
  }
}
