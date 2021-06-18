import 'package:flutter/material.dart';
import 'package:webant_test_app/utils/utils.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CustomAppBar({Key? key, this.leading, this.trailing, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 44.h,
          child: Padding(
            padding: EdgeInsets.only(top: 14.h, left: 16.w),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SizedBox(
                      width: 60.w,
                      height: 44.h,
                      child: leading,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 46.w,
                    height: 44.h,
                    child: GestureDetector(
                      onTap: () => onTap,
                      child: trailing,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 2.h,
        ),
      ],
    );
  }
}
