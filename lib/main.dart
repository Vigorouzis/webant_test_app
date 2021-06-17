import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_bloc.dart';
import 'package:webant_test_app/blocs/load_popular_images_bloc/load_popular_images_bloc.dart';
import 'package:webant_test_app/resources/image_api/image_repository.dart';
import 'package:webant_test_app/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => LoadImageBloc(imageRepository: ImageRepository()),),
              BlocProvider(create: (_) => LoadPopularImageBloc(imageRepository: ImageRepository()),)
            ],
            child: MainScreen()),
      ),
    );
  }
}
