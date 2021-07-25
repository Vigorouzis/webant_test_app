import 'package:webant_test_app/data/datasources/shared_prefs.dart';


class Gateway {
  Gateway({SharedPrefs? prefs}) : _prefs = prefs;
  SharedPrefs? _prefs;

  Future<String?> getAccessToken() async {
    return await _prefs!.read('access_token');
  }

  Future<String?> getClientId() async {
    return await _prefs!.read('client_id');
  }

  Future<String?> getRefreshToken() async {
    return await _prefs!.read('refresh_token');
  }

  Future<String?> setAccessToken({String? value}) async {
    return await _prefs!.save('access_token', value);
  }

  Future<String?> setClientId({String? value}) async {
    return await _prefs!.save('client_id', value);
  }

  Future<String?> setRefreshToken({String? value}) async {
    return await _prefs!.save('refresh_token', value);
  }
}
