import 'package:flutter/material.dart';
import 'package:webant_test_app/utils/utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 44.h,
          child: Padding(
            padding: EdgeInsets.only(top: 14.h, left: 16.w),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: 46.w,
                height: 44.h,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: AppTypography.font15,
                  ),
                ),
              ),
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
