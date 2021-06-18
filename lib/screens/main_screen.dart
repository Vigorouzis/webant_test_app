import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_bloc.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_event.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_state.dart';
import 'package:webant_test_app/blocs/load_popular_images_bloc/load_popular_images_bloc.dart';
import 'package:webant_test_app/blocs/load_popular_images_bloc/load_popular_images_event.dart';
import 'package:webant_test_app/blocs/load_popular_images_bloc/load_popular_images_state.dart';
import 'package:webant_test_app/resources/image_api/image_repository.dart';
import 'package:webant_test_app/screens/detail_image_screen.dart';
import 'package:webant_test_app/screens/profile_screen.dart';
import 'package:webant_test_app/utils/utils.dart';
import 'package:webant_test_app/widgets/icons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TextEditingController? _searchController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController?.addListener(_handleTabSelection);
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _searchController?.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      switch (_tabController!.index) {
        case 0:
          context.read<LoadImageBloc>().add(GetData());
          break;
        case 1:
          context.read<LoadPopularImageBloc>().add(GetPopularData());
          break;
      }
    }
    setState(() {});
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      LoadImageItemScreen(
        tabController: _tabController,
        searchController: _searchController,
      ),
      LoadImageItemScreen(
        tabController: _tabController,
        searchController: _searchController,
      ),
      ProfileScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: AppIcons.homePage(),
            label: '',
            activeIcon: AppIcons.activeHomePage(),
          ),
          BottomNavigationBarItem(
            icon: AppIcons.uploadPhoto(),
            label: '',
            activeIcon: AppIcons.activeUploadPhoto(),
          ),
          BottomNavigationBarItem(
            icon: AppIcons.profile(),
            label: '',
            activeIcon: AppIcons.activeProfile(),
          ),
        ],
      ),
    );
  }
}

class LoadImageItemScreen extends StatefulWidget {
  final TabController? _tabController;
  final TextEditingController? _searchController;

  LoadImageItemScreen(
      {Key? key,
      TabController? tabController,
      TextEditingController? searchController})
      : _tabController = tabController,
        _searchController = searchController,
        super(key: key);

  @override
  _LoadImageItemScreenState createState() => _LoadImageItemScreenState();
}

class _LoadImageItemScreenState extends State<LoadImageItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Container(
            width: 343.w,
            height: 36.h,
            child: TextField(
              controller: widget._searchController,
              decoration: InputDecoration(
                fillColor: Color(0xFF8E8E93).withOpacity(0.12),
                filled: true,
                hintText: context.localize!.search,
                hintStyle: AppTypography.font17.copyWith(
                  color: Colors.black.withOpacity(0.4),
                ),
                contentPadding: EdgeInsets.only(top: 7.h, left: 7.w),
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Material(
          child: TabBar(
            controller: widget._tabController,
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                child: Container(
                  width: 172.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: widget._tabController?.index == 0
                          ? BorderSide(color: Color(0xFFCF497E), width: 2)
                          : BorderSide.none,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      context.localize!.newImages,
                      style: AppTypography.font17.copyWith(
                        color: Color(0xFFC4C4C4),
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  width: 172.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: widget._tabController?.index == 1
                          ? BorderSide(color: Color(0xFFCF497E), width: 2)
                          : BorderSide.none,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      context.localize!.popular,
                      style: AppTypography.font17.copyWith(
                        color: Color(0xFFC4C4C4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: TabBarView(controller: widget._tabController!, children: [
              NewImagesTab(),
              PopularImagesTab(),
            ]),
          ),
        )
      ],
    );
  }
}

class NewImagesTab extends StatefulWidget {
  NewImagesTab({
    Key? key,
  }) : super(key: key);

  @override
  _NewImagesTabState createState() => _NewImagesTabState();
}

class _NewImagesTabState extends State<NewImagesTab>
    with AutomaticKeepAliveClientMixin<NewImagesTab> {
  ScrollController? _controller;
  int _page = 1;

  int _countOfPages = 0;

  ImageRepository? _repository;

  void getCountOfPages() async {
    _countOfPages = (await _repository?.getNewCountOfPages())!;
  }

  @override
  void initState() {
    context.read<LoadImageBloc>().add(LoadNewImage(limit: 10, page: _page));
    _controller = ScrollController();
    _repository = ImageRepository();
    getCountOfPages();
    _controller?.addListener(() {
      if (_controller?.position.pixels ==
          _controller?.position.maxScrollExtent) {
        if (_page != _countOfPages) {
          _page++;
          context
              .read<LoadImageBloc>()
              .add(LoadNewImage(limit: 10, page: _page));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadImageBloc, LoadImageState>(
      builder: (context, state) {
        if (state is LoadImageFailed) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/webant_logo_error.png'),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  context.localize!.sorry,
                  style:
                      AppTypography.font17.copyWith(color: Color(0xFFC4C4C4)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  context.localize!.thereIsNoPictures,
                  style:
                      AppTypography.font12.copyWith(color: Color(0xFFC4C4C4)),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                context.localize!.pleaseComeBackLater,
                style: AppTypography.font12.copyWith(color: Color(0xFFC4C4C4)),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }

        if (state is ImageLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is LoadImageSuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              _page = 1;
              context
                  .read<LoadImageBloc>()
                  .add(LoadNewImage(limit: 10, page: _page, isRefresh: true));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                  controller: _controller,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: state.newImageList!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.newImageList?.length) {
                      return CupertinoActivityIndicator();
                    } else {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailImageScreen(
                              image: state.newImageList![index],
                            ),
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              'http://gallery.dev.webant.ru/media/${state.newImageList?[index]!.name}',
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 166.w,
                            height: 166.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PopularImagesTab extends StatefulWidget {
  PopularImagesTab({Key? key}) : super(key: key);

  @override
  _PopularImagesTabState createState() => _PopularImagesTabState();
}

class _PopularImagesTabState extends State<PopularImagesTab>
    with AutomaticKeepAliveClientMixin<PopularImagesTab> {
  ScrollController? _controller;
  int _page = 1;
  int _countOfPages = 0;

  ImageRepository? _repository;

  void getCountOfPages() async {
    _countOfPages = (await _repository?.getPopularCountOfPages())!;
  }

  @override
  void initState() {
    context
        .read<LoadPopularImageBloc>()
        .add(LoadPopularImage(limit: 10, page: _page, isRefresh: false));
    _controller = ScrollController();
    _repository = ImageRepository();
    getCountOfPages();
    _controller?.addListener(() {
      if (_controller?.position.pixels ==
          _controller?.position.maxScrollExtent) {
        if (_page != _countOfPages) {
          _page++;
          context
              .read<LoadPopularImageBloc>()
              .add(LoadPopularImage(limit: 10, page: _page));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadPopularImageBloc, LoadPopularImageState>(
      builder: (context, state) {
        if (state is LoadPopularImageFailed) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/webant_logo_error.png'),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  context.localize!.sorry,
                  style:
                      AppTypography.font17.copyWith(color: Color(0xFFC4C4C4)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  context.localize!.thereIsNoPictures,
                  style:
                      AppTypography.font12.copyWith(color: Color(0xFFC4C4C4)),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                context.localize!.pleaseComeBackLater,
                style: AppTypography.font12.copyWith(color: Color(0xFFC4C4C4)),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }

        if (state is PopularImageLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is LoadPopularImageSuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              _page = 1;
              context
                  .read<LoadPopularImageBloc>()
                  .add(LoadPopularImage(limit: 10, page: 1, isRefresh: true));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                  controller: _controller,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: state.popularImageFileNameList!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.popularImageFileNameList?.length) {
                      return CupertinoActivityIndicator();
                    } else {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailImageScreen(
                              image: state.popularImageFileNameList![index],
                            ),
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              'http://gallery.dev.webant.ru/media/${state.popularImageFileNameList?[index]!.name}',
                          imageBuilder: (context, imageProvider) => Container(
                            width: 166.w,
                            height: 166.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
