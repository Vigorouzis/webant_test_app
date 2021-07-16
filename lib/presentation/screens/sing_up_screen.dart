import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:webant_test_app/presentation/blocs/registration_bloc/registration_bloc.dart';
import 'package:webant_test_app/presentation/blocs/registration_bloc/registration_event.dart';
import 'package:webant_test_app/presentation/blocs/registration_bloc/registration_state.dart';
import 'package:webant_test_app/presentation/screens/main_screen.dart';
import 'package:webant_test_app/presentation/screens/sing_in_screen.dart';
import 'package:webant_test_app/utils/utils.dart';
import 'package:webant_test_app/presentation/widgets/widgets.dart';

class SingUpScreen extends StatefulWidget {
  SingUpScreen({GlobalKey? key}) : super(key: key);

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

  MaskTextInputFormatter? phoneFormatter;
  MaskTextInputFormatter? birthdayFormatter;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _birthdayController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _usernameController = TextEditingController();
    _phoneController = TextEditingController();
    phoneFormatter = MaskTextInputFormatter(
        mask: '+###########', filter: {"#": RegExp(r'[0-9]')});
    birthdayFormatter = MaskTextInputFormatter(mask: '##.##.####');
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

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    final Size txtSize = _textSize(context.localize!.signUp,
        AppTypography.font30.copyWith(fontWeight: FontWeight.w700));
    return Scaffold(
      appBar: CustomAppBar(
        isMainScreen: false,
        leading: Text(
          context.localize!.cancel,
          style: AppTypography.font15,
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => RegistrationBloc(),
          child: Builder(
            builder: (context) =>
                BlocConsumer<RegistrationBloc, RegistrationState>(
              listener: (context, state) {
                if (state is RegistrationError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message!),
                  ));
                }
                if (state is RegistrationSuccess) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => MainScreen()),
                  );
                }
              },
              builder: (_, state) => Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 100.h),
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      context.localize!.signUp,
                                      style: AppTypography.font30.copyWith(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Container(
                                      width: txtSize.width,
                                      height: 2.h,
                                      color: AppColors.pinkCF497E,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //TODO: найти способ добавит астерикс * в hint
                            CustomTextField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Поле не может быть пустым';
                                }
                                return null;
                              },
                              controller: _nameController,
                              hintText: '${context.localize!.fullName}*',
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, top: 50.h),
                              trailing: AppIcons.user(),
                            ),
                            CustomTextField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Поле не может быть пустым';
                                }
                                return null;
                              },
                              controller: _usernameController,
                              hintText: '${context.localize!.username}*',
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, top: 29.h),
                              trailing: AppIcons.user(),
                            ),
                            CustomTextField(
                              validator: (value) {
                                if (value!.length != 12) {
                                  return 'Номер слишком короткий';
                                }
                                return null;
                              },
                              controller: _phoneController,
                              hintText: '${context.localize!.phone}*',
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, top: 29.h),
                              trailing: Icon(Icons.phone),
                              formatter: phoneFormatter,
                              // error: isPhoneNumber,
                            ),
                            CustomTextField(
                              validator: (value) {
                                if (value!.length != 10 && value.isNotEmpty) {
                                  return 'Не корректно введен день рождения';
                                }
                                if (value.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                              controller: _birthdayController,
                              hintText: context.localize!.birthday,
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, top: 29.h),

                              formatter: birthdayFormatter,
                              //  error: isBirthday,
                            ),
                            CustomTextField(
                              validator: (value) =>
                                  EmailValidator.validate(value!)
                                      ? null
                                      : "Введите правильно email",
                              controller: _emailController,
                              hintText: '${context.localize!.email}*',
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, top: 29.h),
                              trailing: AppIcons.email(),
                            ),
                            CustomTextField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : 'Пароль не может быть пустым',
                              obscureText: _passwordObscureText,
                              controller: _passwordController,
                              hintText: '${context.localize!.password}*',
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, top: 29.h),
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passwordObscureText =
                                        !_passwordObscureText;
                                  });
                                },
                                child: AppIcons.eye(),
                              ),
                            ),
                            CustomTextField(
                              validator: (value) =>
                                  value == _passwordController!.text
                                      ? null
                                      : "Пароли не совпадают",
                              controller: _confirmPasswordController,
                              hintText: "${context.localize!.confirmPassword}*",
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, top: 29.h),
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _confirmPasswordObscureText =
                                        !_confirmPasswordObscureText;
                                  });
                                },
                                child: AppIcons.eye(),
                              ),
                              obscureText: _confirmPasswordObscureText,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 50.h),
                              child: SizedBox(
                                  height: 36.h,
                                  width: 200.w,
                                  child: (() {
                                    if (state is RegistrationLoading) {
                                      return CupertinoActivityIndicator();
                                    }
                                    return ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<RegistrationBloc>().add(
                                                Registration(
                                                    fullName:
                                                        _nameController?.text,
                                                    birthday:
                                                        _birthdayController
                                                            ?.text,
                                                    email:
                                                        _emailController?.text,
                                                    password:
                                                        _passwordController
                                                            ?.text,
                                                    phone:
                                                        _phoneController?.text,
                                                    username:
                                                        _usernameController
                                                            ?.text),
                                              );
                                        }
                                      },
                                      child: Text(
                                        context.localize!.signUp,
                                        style: AppTypography.font17.copyWith(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: AppColors.black1D1D1D),
                                    );
                                  }())),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 19.h, bottom: 50.h),
                              child: TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => SingInScreen(),
                                  ),
                                ),
                                child: Text(
                                  context.localize!.signIn,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
