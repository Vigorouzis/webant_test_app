import 'package:dio/dio.dart';
import 'package:webant_test_app/locator.dart';
import 'package:webant_test_app/models/user.dart';
import 'package:webant_test_app/api/shared_prefs.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class UserApiProvider {
  var _dio = locator.get<Dio>();
  var _prefs = locator.get<SharedPrefs>();

  Future<User?> getProfileInfo() async {
    var clientId = await _prefs.read('client_id');
    var response = await _dio.get('${ApiConstants.profileURL}/$clientId');
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw Exception('Failed load user');
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
}
