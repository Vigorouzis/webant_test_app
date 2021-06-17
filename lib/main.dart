import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_bloc.dart';
import 'package:webant_test_app/blocs/load_popular_images_bloc/load_popular_images_bloc.dart';
import 'package:webant_test_app/blocs/profile_bloc/profile_bloc.dart';
import 'package:webant_test_app/resources/image_api/image_repository.dart';
import 'package:webant_test_app/resources/user_api/user_repository.dart';
import 'package:webant_test_app/screens/main_screen.dart';
import 'package:webant_test_app/screens/splash_screen.dart';
import 'package:webant_test_app/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen()),
      ),
    );
  }
}
