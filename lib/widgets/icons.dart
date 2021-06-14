import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppIcons {
  static Widget email() => SvgPicture.asset(
        'assets/icons/email_text_field.svg',
        width: 24.w,
        height: 16.w,
        fit: BoxFit.none,
      );

  static Widget eye() => SvgPicture.asset(
        'assets/icons/eye_text_field.svg',
        width: 20.w,
        height: 16.w,
        fit: BoxFit.none,
      );
  static Widget user() => SvgPicture.asset(
        'assets/icons/name_text_field.svg',
        width: 18.w,
        height: 18.w,
        fit: BoxFit.none,
      );
  static Widget calendar() => SvgPicture.asset(
        'assets/icons/birthday_text_field.svg',
        width: 22.w,
        height: 22.w,
        fit: BoxFit.none,
      );
}
