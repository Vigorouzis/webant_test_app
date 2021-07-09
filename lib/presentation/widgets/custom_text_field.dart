import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final String? errorText;
  bool? isError;
  final Function(String text)? error;
  final TextInputFormatter? formatter;

  CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.padding,
      this.trailing,
      this.suffixText,
      this.obscureText = false,
      this.maxLines,
      this.height,
      this.errorText,
      this.isError = false,
      this.error,
      this.formatter})
      : super(key: key);

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
        // height: widget.height ?? 36.h,
        child: TextField(
          inputFormatters:
              widget.formatter != null ? [widget.formatter!] : null,
          maxLines: widget.maxLines ?? 1,
          obscureText: widget.obscureText,
          controller: widget.controller,
          onChanged: (value) {
            if (widget.error != null) {
              setState(() {
                widget.isError = widget.error!(value);
              });
              print(widget.isError);
            }
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: widget.isError! == false ? widget.errorText : null,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.pinkCF497E, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.pinkCF497E, width: 1),
            ),
          ),
        ),
      ),
    );
  }
}
