import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:webant_test_app/blocs/auth_bloc/auth_event.dart';
import 'package:webant_test_app/blocs/auth_bloc/auth_state.dart';
import 'package:webant_test_app/screens/main_screen.dart';
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
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => AuthBloc(),
          child: Builder(
            builder: (context) => BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => MainScreen()),
                  );
                }
              },
              builder: (context, state) => SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppBar(
                      leading: Text(
                        'Cancel',
                        style: AppTypography.font15,
                      ),
                    ),
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
                      controller: _usernameController,
                      hintText: 'Username',
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 50.h),
                      trailing: AppIcons.email(),
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 29.h),
                      trailing: AppIcons.eye(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.w, top: 10.h),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot login or password?',
                          style: AppTypography.font13
                              .copyWith(color: Color(0xFFC4C4C4)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: SizedBox(
                        height: 36.h,
                        width: 120.w,
                        child: ElevatedButton(
                          onPressed: () => context.read<AuthBloc>().add(
                                AuthorizationEvent(
                                  email: _usernameController?.text,
                                  password: _passwordController?.text,
                                ),
                              ),
                          child: Text(
                            'Sing In',
                            style: AppTypography.font17
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF1D1D1D)),
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
                          style: AppTypography.font17
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
