import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_bloc.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_event.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_state.dart';
import 'package:webant_test_app/utils/utils.dart';

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
        context: context,
        tabController: _tabController,
        searchController: _searchController,
      ),
      LoadImageItemScreen(
        tabController: _tabController,
        searchController: _searchController,
      ),
      LoadImageItemScreen(
        tabController: _tabController,
        searchController: _searchController,
      ),
    ];

    return Scaffold(
      body: BlocProvider(
        create: (_) => LoadImageBloc(),
        child: Builder(
          builder: (context) => SafeArea(
            child: _children[_currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(icon: new Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: new Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: new Icon(Icons.home), label: ''),
        ],
      ),
    );
  }
}

class LoadImageItemScreen extends StatefulWidget {
  final TabController? _tabController;
  final TextEditingController? _searchController;
  BuildContext? context;

  LoadImageItemScreen(
      {Key? key,
      this.context,
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
                hintText: 'Search',
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
                      'New',
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
                      'Popular',
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
            child: TabBarView(controller: widget._tabController, children: [
              NewImagesTab(
                context: widget.context,
              ),
              NewImagesTab(
                context: widget.context,
              ),
            ]),
          ),
        )
      ],
    );
  }
}

class NewImagesTab extends StatefulWidget {
  BuildContext? context;

  NewImagesTab({Key? key, this.context}) : super(key: key);

  @override
  _NewImagesTabState createState() => _NewImagesTabState();
}

class _NewImagesTabState extends State<NewImagesTab> {
  @override
  void initState() {
    context.read<LoadImageBloc>().add(LoadNewImage(limit: 10, page: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadImageBloc, LoadImageState>(
      builder: (context, state) {
        if (state is ImageLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is LoadImageSuccess) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: state.imageFileNameList?.length,
            itemBuilder: (context, index) => Container(
              width: 166.w,
              height: 166.h,
              child: CachedNetworkImage(
                imageUrl:
                    'http://gallery.dev.webant.ru/media/${state.imageFileNameList?[index]}',
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
