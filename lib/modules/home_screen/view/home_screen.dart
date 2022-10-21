import 'package:flutter/material.dart';
import 'package:netflix/utils/helpers/common_functions.dart';
import '../../../bloc/bloc_builder.dart';
import '../../../modules/home_screen/list/show_type_list.dart';
import '../../../modules/home_screen/list/show_type_list_model.dart';
import '../../../modules/home_screen/list/trending_now_list.dart';
import '../../../modules/home_screen/list/trending_now_list_model.dart';
import '../../../res/strings.dart';
import '../../../res/dimen.dart';
import '../../../utils/custom_widgets/custom_text.dart';
import '../../../modules/home_screen/bloc/home_screen_bloc.dart';
import '../../../modules/home_screen/list/bottom_tab_list.dart';
import '../../../modules/home_screen/list/bottom_tab_list_model.dart';
import '../../../res/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<BottomTabListModel> _bottomTabList = BottomTabList.list;
  final HomeScreenBloc _homeScreenBloc = HomeScreenBloc();
  final List<ShowTypeListModel> _showTypeList = ShowTypeList.list;
  final List<TrendingNowListModel> _trendingNowList = TrendingNowList.list;

  @override
  void initState() {
    super.initState();
    _homeScreenBloc.getLatestMovieApi();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: () {
        return Scaffold(
          backgroundColor: AppColors.black,
          body: ListView(
            children: [
              Stack(
                children: [
                  _buildBanner(),
                  _buildBannerText(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimen.size10, vertical: AppDimen.size20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShowType(),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomText(
                      title: AppStrings.trendingNow,
                      fontSize: AppDimen.size20,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTrendingNow(),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomText(
                      title: AppStrings.newReleases,
                      fontSize: AppDimen.size20,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTrendingNow(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottomNavigationBar(),
        );
      },
      bloc: _homeScreenBloc,
    );
  }

  _buildBanner() {
    return Stack(
      children: <Widget>[
        _buildBannerImage(),
        _buildBannerBlurGradient(),
      ],
    );
  }

  _buildBannerImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            _homeScreenBloc.state.responseModel?.data['poster_path'] ??
                "https://cdn.pixabay.com/photo/2018/01/12/10/19/fantasy-3077928__340.jpg",
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.5,
    );
  }

  _buildBannerBlurGradient() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.grey.withOpacity(0.0),
              Colors.black,
            ],
          ),
        ),
      ),
    );
  }

  _buildBannerText() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildBannerGenreYear(),
            _buildBannerMyListPlayInfo(),
          ],
        ),
      ),
    );
  }

  _buildBannerGenreYear() {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            title: _homeScreenBloc.state.responseModel?.data['title'] ?? '',
            color: AppColors.white,
            fontSize: AppDimen.size16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (_homeScreenBloc.state.responseModel?.data['release_date'] != null &&
            _homeScreenBloc.state.responseModel?.data['release_date'] != '')
          Row(
            children: [
              const SizedBox(
                width: AppDimen.size10,
              ),
              const Icon(
                Icons.circle,
                size: AppDimen.size5,
                color: AppColors.white,
              ),
              const SizedBox(
                width: AppDimen.size10,
              ),
              CustomText(
                title: CommonFunctions().getYearFromDate(
                    _homeScreenBloc.state.responseModel?.data['release_date']),
                color: AppColors.white,
                fontSize: AppDimen.size16,
              ),
            ],
          ),
      ],
    );
  }

  _buildBannerMyListPlayInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBannerMyList(),
        _buildBannerPlay(),
        _buildBannerInfo(),
      ],
    );
  }

  _buildBannerMyList() {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
          color: AppColors.white,
        ),
        const CustomText(
          title: 'My List',
          color: AppColors.white,
        )
      ],
    );
  }

  _buildBannerPlay() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.white)),
      onPressed: () {},
      child: Row(
        children: const [
          Icon(Icons.play_arrow, color: AppColors.black),
          CustomText(
            title: 'Play',
            fontSize: AppDimen.size16,
          ),
        ],
      ),
    );
  }

  _buildBannerInfo() {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.info_outline),
          color: AppColors.white,
        ),
        const CustomText(
          title: 'Info',
          color: AppColors.white,
        )
      ],
    );
  }

  _buildShowType() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: AppDimen.size14),
            child: Stack(
              children: [
                _buildShowTypeImage(_showTypeList, index),
                _buildShowTypeText(index),
              ],
            ),
          );
        },
        itemCount: _showTypeList.length,
      ),
    );
  }

  _buildShowTypeImage(List showTypeList, int index) {
    return Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(showTypeList[index].image), fit: BoxFit.cover),
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(AppDimen.size14)),
      ),
    );
  }

  _buildShowTypeText(int index) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(Radius.circular(AppDimen.size14)),
          color: Colors.white,
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.red.withOpacity(0.3),
              Colors.red.withOpacity(0.6),
            ],
          ),
        ),
        child: Center(
          child: CustomText(
            title: _showTypeList[index].type,
            fontSize: AppDimen.size25,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  _buildTrendingNow() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: AppDimen.size14),
            child: Stack(
              children: [
                _buildShowTypeImage(_trendingNowList, index),
              ],
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: _trendingNowList.length,
      ),
    );
  }

  _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting, // Shifting
      items: List<BottomNavigationBarItem>.generate(
        _bottomTabList.length,
        (index) {
          return _buildBottomNavigationBarItem(index);
        },
      ),
      currentIndex: _homeScreenBloc.state.index,
      // fixedColor: AppColors.black,
      selectedItemColor: AppColors.red.withOpacity(0.7),
      unselectedItemColor: AppColors.white,
      onTap: (int index) {
        setState(() {
          _homeScreenBloc.updateIndex(index);
        });
      },
    );
  }

  _buildBottomNavigationBarItem(int index) {
    return BottomNavigationBarItem(
      icon: _bottomTabList[index].tabIcon,
      label: _bottomTabList[index].tabTitle,
      backgroundColor: _bottomTabList[index].tabColor,
    );
  }
}
