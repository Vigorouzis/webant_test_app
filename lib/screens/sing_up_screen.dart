import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/registration_bloc/registration_bloc.dart';
import 'package:webant_test_app/blocs/registration_bloc/registration_event.dart';
import 'package:webant_test_app/blocs/registration_bloc/registration_state.dart';
import 'package:webant_test_app/screens/main_screen.dart';
import 'package:webant_test_app/screens/sing_in_screen.dart';
import 'package:webant_test_app/utils/utils.dart';
import 'package:webant_test_app/widgets/custom_app_bar.dart';
import 'package:webant_test_app/widgets/custom_text_field.dart';
import 'package:webant_test_app/widgets/icons.dart';

class SingUpScreen extends StatefulWidget {
  SingUpScreen({Key? key}) : super(key: key);

  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController? _nameController;
  TextEditingController? _birthdayController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;
  TextEditingController? _usernameController;
  TextEditingController? _phoneController;
  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;

  @override
  void initState() {
    _nameController = TextEditingController();
    _birthdayController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _usernameController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _birthdayController?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    _confirmPasswordController?.dispose();
    _usernameController?.dispose();
    _phoneController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => RegistrationBloc(),
          child: Builder(
            builder: (context) =>
                BlocConsumer<RegistrationBloc, RegistrationState>(
              listener: (context, state) {
                if (state is RegistrationSuccess) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => MainScreen()),
                  );
                }
              },
              builder: (_, state) => SingleChildScrollView(
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
                    //TODO: найти способ добавит астерикс * в hint
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'User Name',
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 50.h),
                      trailing: AppIcons.user(),
                      suffixText: '*',
                    ),
                    CustomTextField(
                      controller: _usernameController,
                      hintText: 'Username',
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 29.h),
                      trailing: AppIcons.user(),
                      suffixText: '*',
                    ),
                    CustomTextField(
                      controller: _phoneController,
                      hintText: 'Phone',
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 29.h),
                      trailing: Icon(Icons.phone),
                      suffixText: '*',
                    ),
                    CustomTextField(
                      controller: _birthdayController,
                      hintText: 'Birthday',
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 29.h),
                      trailing: AppIcons.calendar(),
                    ),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 29.h),
                      trailing: AppIcons.email(),
                      suffixText: '*',
                    ),
                    CustomTextField(
                      obscureText: _passwordObscureText,
                      controller: _passwordController,
                      hintText: 'Password',
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 29.h),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordObscureText = !_passwordObscureText;
                          });
                        },
                        child: AppIcons.eye(),
                      ),
                      suffixText: '*',
                    ),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm password',
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 29.h),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            _confirmPasswordObscureText =
                                !_confirmPasswordObscureText;
                          });
                        },
                        child: AppIcons.eye(),
                      ),
                      suffixText: '*',
                      obscureText: _confirmPasswordObscureText,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: SizedBox(
                        height: 36.h,
                        width: 120.w,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_passwordController?.text ==
                                _confirmPasswordController?.text) {
                              context.read<RegistrationBloc>().add(
                                    Registration(
                                        fullName: _nameController?.text,
                                        birthday: _birthdayController?.text,
                                        email: _emailController?.text,
                                        password: _passwordController?.text,
                                        phone: _phoneController?.text,
                                        username: _usernameController?.text),
                                  );
                            }
                          },
                          child: Text(
                            'Sing Up',
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
                            builder: (_) => SingInScreen(),
                          ),
                        ),
                        child: Text(
                          'Sing In',
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
