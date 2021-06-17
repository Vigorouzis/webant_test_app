import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webant_test_app/models/image.dart';
import 'package:webant_test_app/widgets/custom_app_bar.dart';
import 'package:webant_test_app/widgets/icons.dart';
import 'package:webant_test_app/utils/utils.dart';

class DetailImageScreen extends StatelessWidget {
  final ImageModel? image;

  const DetailImageScreen({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              leading: AppIcons.backArrow(),
            ),
            Container(
              width: 375.w,
              height: 251.h,
              child: CachedNetworkImage(
                imageUrl: 'http://gallery.dev.webant.ru/media/${image!.name!}',
              ),
            ),
            Row(
              children: [
                Text(image!.name!.substring(0, image!.name!.indexOf('.'))),
                Spacer(),
                Text(image!.dateCreate!),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 10.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      image!.user == null ? 'Not indicated' : image!.user!)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 20.h, right: 16.w),
              child: Container(width: 343.w, child: Text(image!.description!)),
            ),
          ],
        ),
      ),
    );
  }
}
