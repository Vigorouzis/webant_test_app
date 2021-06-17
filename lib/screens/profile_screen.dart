import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/profile_bloc/profile_bloc.dart';
import 'package:webant_test_app/blocs/profile_bloc/profile_event.dart';
import 'package:webant_test_app/blocs/profile_bloc/profile_state.dart';
import 'package:webant_test_app/widgets/custom_app_bar.dart';
import 'package:webant_test_app/utils/utils.dart';
import 'package:webant_test_app/widgets/icons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetDataAboutProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileSuccess) {
              return Column(
                children: [
                  CustomAppBar(
                    leading: AppIcons.backArrow(),
                    trailing: AppIcons.settings(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 21.h),
                    child: Container(
                        height: 100.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(0xFFC4C4C4))),
                        child: AppIcons.profilePhoto()),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      state.user.username,
                      style: AppTypography.font17,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      state.user.birthday,
                      style: AppTypography.font12
                          .copyWith(color: Color(0xFFC4C4C4)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 27.h, left: 16.w),
                    child: Row(
                      children: [
                        Text(
                          'Loaded: ',
                          style: AppTypography.font12,
                        ),
                        Text(
                          '999+',
                          style: AppTypography.font12
                              .copyWith(color: Color(0xFFC4C4C4)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Divider(height: 2.h, color: Color(0xFFC4C4C4)),
                  ),
                  state.user.uploadImages!.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemCount: state.user.uploadImages!.length + 1,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 166.w,
                                  height: 166.h,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'http://gallery.dev.webant.ru/media/${state.user.uploadImages?[index]}',
                                  ),
                                );
                              }),
                        )
                      : Center(
                          child: Text('Нет фоток'),
                        ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
