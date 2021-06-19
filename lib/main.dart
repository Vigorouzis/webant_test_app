import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_bloc.dart';
import 'package:webant_test_app/blocs/load_popular_images_bloc/load_popular_images_bloc.dart';
import 'package:webant_test_app/blocs/profile_bloc/profile_bloc.dart';
import 'package:webant_test_app/resources/image_api/image_repository.dart';
import 'package:webant_test_app/resources/shared_prefs.dart';
import 'package:webant_test_app/resources/user_api/user_repository.dart';
import 'package:webant_test_app/screens/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webant_test_app/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String?> getAccessToken() async {
    SharedPrefs _prefs = SharedPrefs();
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
                LoadImageBloc(imageRepository: ImageRepository()),
          ),
          BlocProvider(
            create: (context) =>
                LoadPopularImageBloc(imageRepository: ImageRepository()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(userRepository: UserRepository()),
          )
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
