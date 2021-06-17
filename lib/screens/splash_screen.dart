import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_bloc.dart';
import 'package:webant_test_app/blocs/load_popular_images_bloc/load_popular_images_bloc.dart';
import 'package:webant_test_app/blocs/profile_bloc/profile_bloc.dart';
import 'package:webant_test_app/resources/image_api/image_repository.dart';
import 'package:webant_test_app/resources/user_api/user_repository.dart';
import 'package:webant_test_app/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/icons/webant_logo.png'),
      ),
    );
  }
}
