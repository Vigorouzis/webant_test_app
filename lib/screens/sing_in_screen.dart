import 'package:flutter/material.dart';
import 'package:webant_test_app/screens/sing_up_screen.dart';
import 'package:webant_test_app/utils/utils.dart';
import 'package:webant_test_app/widgets/custom_app_bar.dart';
import 'package:webant_test_app/widgets/custom_text_field.dart';
import 'package:webant_test_app/widgets/icons.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({Key? key}) : super(key: key);

  @override
  _SingInScreenState createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),
            Padding(
              padding: EdgeInsets.only(top: 100.h),
              child: SizedBox(
                child: Column(
                  children: [
                    Text(
                      'Sing in',
                      style: AppTypography.font30
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Container(
                      width: 94.w,
                      height: 2.h,
                      color: Color(0xFFCF497E),
                    )
                  ],
                ),
              ),
            ),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email',
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 50.h),
              trailing: AppIcons.email(),
            ),
            CustomTextField(
              controller: _emailController,
              hintText: 'Password',
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 29.h),
              trailing: AppIcons.eye(),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.w, top: 10.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot login or password?',
                  style:
                      AppTypography.font13.copyWith(color: Color(0xFFC4C4C4)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: SizedBox(
                height: 36.h,
                width: 120.w,
                child: ElevatedButton(
                  onPressed: () => print('hello'),
                  child: Text(
                    'Sing In',
                    style: AppTypography.font17
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  style: ElevatedButton.styleFrom(primary: Color(0xFF1D1D1D)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 19.h),
              child: TextButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => SingUpScreen(),
                  ),
                ),
                child: Text(
                  'Sing Up',
                  style: AppTypography.font17.copyWith(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
