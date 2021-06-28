import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:webant_test_app/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:webant_test_app/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:webant_test_app/presentation/screens/main_screen.dart';
import 'package:webant_test_app/presentation/screens/sing_up_screen.dart';
import 'package:webant_test_app/utils/utils.dart';
import 'package:webant_test_app/presentation/widgets/widgets.dart';

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
              builder: (context, state) => Column(
                children: [
                  CustomAppBar(
                    leading: Text(
                      context.localize!.cancel,
                      style: AppTypography.font15,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 100.h),
                            child: SizedBox(
                              child: Column(
                                children: [
                                  Text(
                                    context.localize!.signIn,
                                    style: AppTypography.font30
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  Container(
                                    width: 94.w,
                                    height: 2.h,
                                    color: AppColors.pinkCF497E,
                                  )
                                ],
                              ),
                            ),
                          ),
                          CustomTextField(
                            controller: _usernameController,
                            hintText: context.localize!.username,
                            padding: EdgeInsets.only(
                                left: 16.w, right: 16.w, top: 50.h),
                            trailing: AppIcons.email(),
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: context.localize!.password,
                            padding: EdgeInsets.only(
                                left: 16.w, right: 16.w, top: 29.h),
                            trailing: AppIcons.eye(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8.w, top: 10.h),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                context.localize!.forgotLoginOrPassword,
                                style: AppTypography.font13
                                    .copyWith(color: AppColors.greyC4C4C4),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 50.h),
                            child: SizedBox(
                              height: 36.h,
                              width: 120.w,
                              child: (() {
                                if (state is AuthLoading) {
                                  return CupertinoActivityIndicator();
                                }
                                return ElevatedButton(
                                  onPressed: () {
                                    if (_usernameController!.text.isNotEmpty &&
                                        _passwordController!.text.isNotEmpty) {
                                      context.read<AuthBloc>().add(
                                            AuthorizationEvent(
                                              email: _usernameController?.text,
                                              password:
                                                  _passwordController?.text,
                                            ),
                                          );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(context
                                              .localize!.notAllFieldsAreFilled),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    context.localize!.signIn,
                                    style: AppTypography.font17
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColors.black1D1D1D),
                                );
                              }()),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 19.h),
                            child: TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => SingUpScreen(),
                                ),
                              ),
                              child: Text(
                                context.localize!.signUp,
                                style: AppTypography.font17
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
