import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webant_test_app/screens/sing_in_screen.dart';
import 'package:webant_test_app/screens/sing_up_screen.dart';
import 'package:webant_test_app/utils/fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 248.h),
                child: Text(
                  'Welcome!',
                  style: AppTypography.font20.copyWith(color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: SizedBox(
                  height: 36.h,
                  width: 343.w,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SingUpScreen(),
                      ),
                    ),
                    child: Text(
                      'Create an account',
                      style: AppTypography.font14,
                    ),
                    style: ElevatedButton.styleFrom(primary: Color(0xFF1D1D1D)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: SizedBox(
                  height: 36.h,
                  width: 343.w,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SingInScreen(),
                      ),
                    ),
                    child: Text(
                      'I already have an account',
                      style: AppTypography.font14.copyWith(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      onSurface: Color(0xFF1D1D1D),
                      primary: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
