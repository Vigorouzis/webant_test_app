import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webant_test_app/utils/utils.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Function(int)? popFunc;

  const CustomAppBar(
      {Key? key, this.leading, this.trailing, this.onTap, this.popFunc})
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
                    onTap: () => popFunc!(0),
                    child: Container(
                      color: Colors.white10,
                      width: 60.w,
                      height: 44.h,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: leading),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () => onTap,
                    child: SizedBox(
                      width: 100.w,
                      height: 44.h,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: trailing,
                      ),
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
