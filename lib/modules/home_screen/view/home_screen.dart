import 'package:flutter/material.dart';
import 'package:netflix/utils/custom_widgets/custom_snackbar.dart';
import '../../../modules/home_screen/view/trending_now.dart';
import '../../../modules/home_screen/view/home_banner.dart';
import '../../../bloc/bloc_builder.dart';
import '../../../res/strings.dart';
import '../../../res/dimen.dart';
import '../../../utils/custom_widgets/custom_text.dart';
import '../../../modules/home_screen/bloc/home_screen_bloc.dart';
import '../../../modules/home_screen/list/bottom_tab_list.dart';
import '../../../modules/home_screen/list/bottom_tab_list_model.dart';
import '../../../res/colors.dart';
import 'show_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<BottomTabListModel> _bottomTabList = BottomTabList.list;
  final HomeScreenBloc _homeScreenBloc = HomeScreenBloc();

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
              HomeBanner(
                homeScreenBloc: _homeScreenBloc,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimen.size10, vertical: AppDimen.size20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShowType(),
                    _buildSizedBox(AppDimen.size20),
                    const CustomText(
                      title: AppStrings.trendingNow,
                      fontSize: AppDimen.size20,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    _buildSizedBox(AppDimen.size10),
                    TrendingNow(
                      homeScreenBloc: _homeScreenBloc,
                    ),
                    _buildSizedBox(AppDimen.size20),
                    const CustomText(
                      title: AppStrings.newReleases,
                      fontSize: AppDimen.size20,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    _buildSizedBox(AppDimen.size10),
                    TrendingNow(
                      homeScreenBloc: _homeScreenBloc,
                    ),
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

  _buildSizedBox(double height) {
    return SizedBox(
      height: height,
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
        _homeScreenBloc.updateIndex(index);
        CustomSnackbar.showSnackBar(
            context: context,
            message:
                '${_bottomTabList[_homeScreenBloc.state.index].tabTitle} clicked',
            backgroundColor: AppColors.blue);
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
