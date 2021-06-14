import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class AuthApiProvider {
  Future<void> authorization() async {
    //Response response = await Dio().get(ApiConstants.singUpURL) ;
  }

  Future<void> registrationNewUser({
    String? fullName,
    String? birthday,
    String? email,
    String? password,
  }) async {
    var params = {
      'email': email,
      'fullName': fullName,
      'password': password,
      "birthday": birthday,
    };

    Response response = await Dio().post(ApiConstants.singUpURL,
        data: jsonEncode(params),
        options: Options(
          contentType: 'application/json',
        ));

    print(response);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);
    }
  }
}
