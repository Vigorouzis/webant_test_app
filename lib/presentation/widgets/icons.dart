import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppIcons {
  static Widget email() => SvgPicture.asset(
        'assets/icons/email_text_field.svg',
        width: 24.w,
        height: 16.h,
        fit: BoxFit.none,
      );

  static Widget eye() => SvgPicture.asset(
        'assets/icons/eye_text_field.svg',
        width: 20.w,
        height: 16.h,
        fit: BoxFit.none,
      );

  static Widget user() => SvgPicture.asset(
        'assets/icons/name_text_field.svg',
        width: 18.w,
        height: 18.h,
        fit: BoxFit.none,
      );

  static Widget calendar() => SvgPicture.asset(
        'assets/icons/birthday_text_field.svg',
        width: 22.w,
        height: 22.h,
        fit: BoxFit.none,
      );

  static Widget homePage() => SvgPicture.asset(
        'assets/icons/house.svg',
        width: 24.w,
        height: 23.h,
        fit: BoxFit.none,
      );

  static Widget activeHomePage() => SvgPicture.asset(
        'assets/icons/house.svg',
        width: 24.w,
        height: 23.h,
        fit: BoxFit.none,
        color: Color(0xFFCF497E),
      );

  static Widget uploadPhoto() => SvgPicture.asset(
        'assets/icons/camera.svg',
        width: 28.w,
        height: 22.h,
        fit: BoxFit.none,
      );

  static Widget activeUploadPhoto() => SvgPicture.asset(
        'assets/icons/camera.svg',
        width: 28.w,
        height: 22.h,
        fit: BoxFit.none,
        color: Color(0xFFCF497E),
      );

  static Widget profile() => SvgPicture.asset(
        'assets/icons/profile.svg',
        width: 24.w,
        height: 23.h,
        fit: BoxFit.none,
      );

  static Widget activeProfile() => SvgPicture.asset(
        'assets/icons/profile.svg',
        width: 24.w,
        height: 23.h,
        fit: BoxFit.none,
        color: Color(0xFFCF497E),
      );

  static Widget profilePhoto() => SvgPicture.asset(
        'assets/icons/profile_photo.svg',
        width: 54.w,
        height: 42.h,
        fit: BoxFit.none,
      );

  static Widget settings() => SvgPicture.asset(
        'assets/icons/settings.svg',
        width: 22.w,
        height: 22.h,
        fit: BoxFit.none,
      );

  static Widget backArrow() => SvgPicture.asset(
        'assets/icons/back_arrow.svg',
        width: 7.w,
        height: 13.h,
        fit: BoxFit.none,
      );


}
