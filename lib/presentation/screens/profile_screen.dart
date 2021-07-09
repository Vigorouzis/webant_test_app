import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:webant_test_app/presentation/blocs/profile_bloc/profile_event.dart';
import 'package:webant_test_app/presentation/blocs/profile_bloc/profile_state.dart';
import 'package:webant_test_app/presentation/screens/profile_settings_screen.dart';
import 'package:webant_test_app/presentation/widgets/widgets.dart';
import 'package:webant_test_app/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  final Function(int)? onTabTapped;

  const ProfileScreen({Key? key, this.onTabTapped}) : super(key: key);

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
        child: RefreshIndicator(
          onRefresh: () async =>
              context.read<ProfileBloc>().add(GetDataAboutProfile()),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileFailed) {
                return ListView(
                  children: [
                    Container(
                      height: 220.h,
                      child: Text(''),
                    ),
                    AppIcons.webantErrorLogo(),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        context.localize!.sorry,
                        style: AppTypography.font17
                            .copyWith(color: AppColors.greyC4C4C4),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        context.localize!.noProfileData,
                        style: AppTypography.font12
                            .copyWith(color: AppColors.greyC4C4C4),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      context.localize!.pleaseComeBackLater,
                      style: AppTypography.font12
                          .copyWith(color: AppColors.greyC4C4C4),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }

              if (state is ProfileLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProfileSuccess) {
                return Column(
                  children: [
                    CustomAppBar(
                      popFunc: widget.onTabTapped,
                      leading: AppIcons.backArrow(),
                      trailing: GestureDetector(
                          onTap: () async {
                            var newUser = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProfileSettingsScreen(
                                  user: state.user,
                                ),
                              ),
                            );
                            if (newUser != null) {
                              context
                                  .read<ProfileBloc>()
                                  .add(GetDataAboutProfile());
                            }
                          },
                          child: AppIcons.settings()),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 21.h),
                      child: Container(
                          height: 100.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.greyC4C4C4)),
                          child: AppIcons.profilePhoto()),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        state.user!.username,
                        style: AppTypography.font17,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        state.user!.birthday,
                        style: AppTypography.font12
                            .copyWith(color: AppColors.greyC4C4C4),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 27.h, left: 16.w),
                      child: Row(
                        children: [
                          Text(
                            context.localize!.loaded,
                            style: AppTypography.font12,
                          ),
                          Text(
                            '999+',
                            style: AppTypography.font12
                                .copyWith(color: AppColors.greyC4C4C4),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Divider(height: 2.h, color: AppColors.greyC4C4C4),
                    ),
                    if (state.user!.uploadImages!.isNotEmpty)
                      Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            itemCount: state.user!.uploadImages!.length + 1,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 166.w,
                                height: 166.h,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'http://gallery.dev.webant.ru/media/${state.user!.uploadImages?[index]}',
                                ),
                              );
                            }),
                      )
                    else
                      Center(
                        child: Text(context.localize!.noPhoto),
                      ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
