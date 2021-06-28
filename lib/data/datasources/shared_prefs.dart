import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPreferences? _preferences;

  SharedPrefs({SharedPreferences? preferences}) : _preferences = preferences;

  Future<dynamic> read(String key) async {
    var a = _preferences?.getString(key);
    return a;
  }

  Future<dynamic> contains(String key) async {
    return _preferences?.containsKey(key);
  }

  Future<dynamic> save(String key, value) async {
    _preferences?.setString(key, jsonEncode(value));
  }

  Future<dynamic> clear() async {
    _preferences?.clear();
  }
}
