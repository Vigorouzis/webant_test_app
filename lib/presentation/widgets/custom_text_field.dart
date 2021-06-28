import 'package:flutter/material.dart';
import 'package:webant_test_app/utils/utils.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final EdgeInsetsGeometry padding;
  final Widget? trailing;
  final String? suffixText;
  final bool obscureText;
  final int? maxLines;
  final double? height;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.padding,
    this.trailing,
    this.suffixText,
    this.obscureText = false,
    this.maxLines,
    this.height,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        width: 343.w,
        height: widget.height ?? 36.h,
        child: TextField(
          maxLines: widget.maxLines ?? 1,
          obscureText: widget.obscureText,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixText: widget.suffixText,
            suffixStyle: TextStyle(
              color: Colors.red,
            ),
            contentPadding: EdgeInsets.only(top: 7.h, left: 10.w),
            hintStyle: AppTypography.font17.copyWith(
              color: AppColors.greyC4C4C4,
            ),
            suffixIcon: widget.trailing ?? null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.greyC4C4C4, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.greyC4C4C4, width: 1),
            ),
          ),
        ),
      ),
    );
  }
}