import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webant_test_app/presentation/screens/sing_in_screen.dart';
import 'package:webant_test_app/presentation/screens/sing_up_screen.dart';
import 'package:webant_test_app/utils/utils.dart';

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
                padding: EdgeInsets.only(top: 120.h),
                child: Image.asset('assets/icons/webant_logo.png'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Text(
                  context.localize!.welcome,
                  style: AppTypography.font20.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700),
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
                      context.localize!.createAnAccount,
                      style: AppTypography.font14,
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.black1D1D1D),
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
                      context.localize!.iAlreadyHaveAnAccount,
                      style: AppTypography.font14.copyWith(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      onSurface: AppColors.black1D1D1D,
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
