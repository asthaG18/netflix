import 'package:flutter/material.dart';
import '../../../modules/home_screen/bloc/home_screen_bloc.dart';
import '../../../res/colors.dart';
import '../../../res/dimen.dart';
import '../../../res/strings.dart';
import '../../../utils/helpers/routes.dart';

class TrendingNow extends StatefulWidget {
  const TrendingNow({super.key, required this.homeScreenBloc});
  final HomeScreenBloc homeScreenBloc;

  @override
  State<TrendingNow> createState() => _TrendingNowState();
}

class _TrendingNowState extends State<TrendingNow> {
  _navigateToDetailScreen(int id) {
    Navigator.of(context).pushNamed(
      AppRoutes.detailScreen,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTrendingNow();
  }

  _buildTrendingNow() {
    return SizedBox(
      height: AppDimen.size200,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: AppDimen.size14),
            child: _buildMovieImage(index),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount:
            widget.homeScreenBloc.state.trendingNowResponseModel?.data.length,
      ),
    );
  }

  _buildMovieImage(int index) {
    return GestureDetector(
      onTap: () {
        _navigateToDetailScreen(widget
            .homeScreenBloc.state.trendingNowResponseModel?.data[index]['id']);
      },
      child: Container(
        height: AppDimen.size200,
        width: AppDimen.size140,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: widget.homeScreenBloc.state.trendingNowResponseModel
                          ?.data[index]['poster_path'] !=
                      null
                  ? NetworkImage(
                      '${AppStrings.imagePath}${widget.homeScreenBloc.state.trendingNowResponseModel?.data[index]['poster_path']}')
                  : const NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                    ),
              fit: BoxFit.cover),
          color: AppColors.white,
          borderRadius:
              const BorderRadius.all(Radius.circular(AppDimen.size14)),
        ),
      ),
    );
  }
}
