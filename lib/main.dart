import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webant_test_app/data/datasources/shared_prefs.dart';
import 'package:webant_test_app/data/repositories/image_repository_impl.dart';
import 'package:webant_test_app/data/repositories/send_image_repository_impl.dart';
import 'package:webant_test_app/data/repositories/user_repository_impl.dart';
import 'package:webant_test_app/presentation/blocs/load_image_bloc/load_image_bloc.dart';
import 'package:webant_test_app/presentation/blocs/load_popular_images_bloc/load_popular_images_bloc.dart';
import 'package:webant_test_app/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:webant_test_app/presentation/blocs/profile_setting_bloc/profile_setting_bloc.dart';
import 'package:webant_test_app/presentation/blocs/send_image_bloc/send_image_bloc.dart';
import 'package:webant_test_app/locator.dart';
import 'package:webant_test_app/presentation/screens/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webant_test_app/presentation/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String?> getAccessToken() async {
    SharedPrefs _prefs = locator<SharedPrefs>();
    String? _accessToken = await _prefs.read('access_token');
    return _accessToken;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                LoadImageBloc(imageRepository: ImageRepositoryImpl()),
          ),
          BlocProvider(
            create: (context) =>
                LoadPopularImageBloc(imageRepository: ImageRepositoryImpl()),
          ),
          BlocProvider(
            create: (context) =>
                ProfileBloc(userRepository: UserRepositoryImpl()),
          ),
          BlocProvider(
            create: (_) => SendImageBloc(repository: SendImageRepositoryImpl()),
          ),
          BlocProvider(
              create: (_) =>
                  ProfileSettingsBloc(repository: UserRepositoryImpl()))
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder<String?>(
              future: getAccessToken(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MainScreen();
                } else {
                  return WelcomeScreen();
                }
              }),
        ),
      ),
    );
  }
}
