import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webant_test_app/data/datasources/gateway.dart';
import 'package:webant_test_app/data/datasources/shared_prefs.dart';
import 'package:webant_test_app/data/models/user.dart';
import 'package:webant_test_app/data/repositories/auth_repository_impl.dart';
import 'package:webant_test_app/data/repositories/image_repository_impl.dart';
import 'package:webant_test_app/data/repositories/send_image_repository_impl.dart';
import 'package:webant_test_app/data/repositories/user_repository_impl.dart';
import 'package:webant_test_app/token_interceptor.dart';

final injection = GetIt.I;

Future<void> setDI() async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  injection.registerLazySingleton(() => _sharedPreferences);
  SharedPrefs sharedPreferences =
      SharedPrefs(preferences: injection.get<SharedPreferences>());
  injection.registerLazySingleton(() => sharedPreferences);

  injection.registerLazySingleton<Gateway>(
      () => Gateway(prefs: injection.get<SharedPrefs>()));

  final Dio dio = Dio(BaseOptions(
    contentType: 'application/json',
    sendTimeout: 10000,
    connectTimeout: 20000,
  ));
  injection.registerLazySingleton(() => dio);

  dio.interceptors.add(TokenInterceptor(
      dio: injection.get<Dio>(), preferences: injection.get<SharedPrefs>()));

  injection
      .registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl());
  injection.registerLazySingleton<User>(() => User());
  injection
      .registerLazySingleton<ImageRepositoryImpl>(() => ImageRepositoryImpl());
  injection
      .registerLazySingleton<UserRepositoryImpl>(() => UserRepositoryImpl());
  injection.registerLazySingleton<SendImageRepositoryImpl>(
      () => SendImageRepositoryImpl());
}
