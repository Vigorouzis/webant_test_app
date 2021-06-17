import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.network(
              'http://gallery.dev.webant.ru/media/5f98883c96019993214838.jpg')),
    );
  }
}
