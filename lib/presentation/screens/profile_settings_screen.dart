import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/data/datasources/date_helper.dart';
import 'package:webant_test_app/presentation/blocs/profile_setting_bloc/profile_setting_bloc.dart';
import 'package:webant_test_app/presentation/blocs/profile_setting_bloc/profile_settings_event.dart';
import 'package:webant_test_app/presentation/blocs/profile_setting_bloc/profile_settings_state.dart';
import 'package:webant_test_app/data/models/user.dart';
import 'package:webant_test_app/presentation/screens/welcome_screen.dart';
import 'package:webant_test_app/presentation/widgets/widgets.dart';
import 'package:webant_test_app/utils/utils.dart';

class ProfileSettingsScreen extends StatefulWidget {
  final User? _user;

  const ProfileSettingsScreen({Key? key, User? user})
      : _user = user,
        super(key: key);

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  TextEditingController? _usernameController;
  TextEditingController? _birthdayController;
  TextEditingController? _emailController;
  TextEditingController? _oldPasswordController;
  TextEditingController? _newPasswordController;
  TextEditingController? _confirmPasswordController;

  @override
  void initState() {
    _usernameController = TextEditingController(text: widget._user!.username);
    _birthdayController =
        TextEditingController(text: widget._user!.birthday.toString());
    _emailController = TextEditingController(text: widget._user!.email);
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    context
        .read<ProfileSettingsBloc>()
        .emit(InitProfileSettingsState(user: widget._user));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController!.dispose();
    _birthdayController!.dispose();
    _emailController!.dispose();
    _oldPasswordController!.dispose();
    _newPasswordController!.dispose();
    _confirmPasswordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfileSettingsBloc, ProfileSettingsState>(
          listener: (context, state) {
            if (state is ProfileSettingsLoaded) {
              Navigator.of(context).pop(state.user);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.localize!.dataChanged),
                ),
              );
            }
          },
          builder: (context, state) => SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  isMainScreen: false,
                  leading: Text(
                    context.localize!.cancel,
                    style: AppTypography.font15
                        .copyWith(color: AppColors.grey5F5F5F),
                  ),
                  trailing: (() {
                    if (state is ProfileSettingsLoadingState) {
                      return CupertinoActivityIndicator();
                    }
                    return GestureDetector(
                      onTap: () =>
                          context.read<ProfileSettingsBloc>().add(SendDataToApi(
                                username: _usernameController!.text,
                                phone: widget._user!.phone,
                                email: _emailController!.text,
                                birthday: _birthdayController!.text == 'null'
                                    ? null
                                    : DateHelper.getDateFromString(
                                        date: _birthdayController!.text),
                                fullName: widget._user!.name,
                                oldPassword: _oldPasswordController!.text,
                                newPassword: _newPasswordController!.text,
                              )),
                      child: Text(
                        context.localize!.save,
                        style: AppTypography.font15.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.pinkCF497E),
                      ),
                    );
                  }()),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 21.h),
                  child: Container(
                      height: 100.w,
                      width: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.greyC4C4C4),
                      ),
                      child: AppIcons.profilePhoto()),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        context.read<ProfileSettingsBloc>().add(
                              SetProfileAvatar(user: widget._user),
                            );
                      });
                    },
                    child: Text(
                      context.localize!.uploadPhoto,
                      style: AppTypography.font12
                          .copyWith(color: AppColors.greyC4C4C4),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 16.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.localize!.personalData,
                      style: AppTypography.font14,
                    ),
                  ),
                ),
                CustomTextField(
                  controller: _usernameController,
                  hintText: context.localize!.username,
                  padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                  trailing: AppIcons.user(),
                ),
                CustomTextField(
                  controller: _birthdayController,
                  hintText: context.localize!.birthday,
                  padding: EdgeInsets.only(top: 29.h, left: 16.w, right: 16.w),
                  trailing: AppIcons.calendar(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 39.h, left: 16.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.localize!.emailAddress,
                      style: AppTypography.font14,
                    ),
                  ),
                ),
                CustomTextField(
                  controller: _emailController,
                  hintText: context.localize!.email,
                  padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                  trailing: AppIcons.email(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 39.h, left: 16.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.localize!.password,
                      style: AppTypography.font14,
                    ),
                  ),
                ),
                CustomTextField(
                  controller: _oldPasswordController,
                  hintText: context.localize!.oldPassword,
                  padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                  trailing: AppIcons.email(),
                ),
                CustomTextField(
                  controller: _newPasswordController,
                  hintText: context.localize!.newPassword,
                  padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                  trailing: AppIcons.email(),
                ),
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: context.localize!.confirmPassword,
                  padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                  trailing: AppIcons.email(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 39.h, left: 16.w),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => print('hello'),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: context.localize!.youCan,
                                style: AppTypography.font14
                                    .copyWith(color: Colors.black)),
                            TextSpan(
                                text: context.localize!.deleteYourAccount,
                                style: AppTypography.font14
                                    .copyWith(color: AppColors.pinkCF497E)),
                          ]),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 16.w, bottom: 86.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        context.localize!.signOut,
                        style: AppTypography.font14
                            .copyWith(color: AppColors.pinkCF497E),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
