import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:webant_test_app/data/datasources/auth_api_provider.dart';
import 'package:webant_test_app/data/datasources/image_api_provider.dart';
import 'package:webant_test_app/data/datasources/send_image_api.dart';
import 'package:webant_test_app/data/datasources/shared_prefs.dart';
import 'package:webant_test_app/data/datasources/user_api_provider.dart';

import 'package:webant_test_app/token_interceptor.dart';

final injection = GetIt.I;

Future<void> setDI() async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  injection.registerLazySingleton(() => _sharedPreferences);
  SharedPrefs sharedPreferences =
      SharedPrefs(preferences: injection.get<SharedPreferences>());
  injection.registerLazySingleton(() => sharedPreferences);

  final Dio dio = Dio(BaseOptions(
    contentType: 'application/json',
    sendTimeout: 10000,
    connectTimeout: 20000,
  ));
  injection.registerLazySingleton(() => dio);

  dio.interceptors.add(TokenInterceptor(
      dio: injection.get<Dio>(), preferences: injection.get<SharedPrefs>()));

  injection.registerLazySingleton<AuthApiProvider>(() => AuthApiProvider());
  injection.registerLazySingleton<ImageApiProvider>(() => ImageApiProvider());
  injection.registerLazySingleton<UserApiProvider>(() => UserApiProvider());
  injection.registerLazySingleton<SendImageApiProvider>(
      () => SendImageApiProvider());
}
