import 'package:flutter/material.dart';
import '../../../utils/custom_widgets/custom_snackbar.dart';
import '../../../utils/helpers/routes.dart';
import '../../../res/strings.dart';
import '../../../modules/home_screen/bloc/home_screen_bloc.dart';
import '../../../res/colors.dart';
import '../../../res/dimen.dart';
import '../../../utils/custom_widgets/custom_text.dart';
import '../../../utils/helpers/common_functions.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key, required this.homeScreenBloc});
  final HomeScreenBloc homeScreenBloc;
  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  _navigateToDetailScreen(int id) {
    Navigator.of(context).pushNamed(
      AppRoutes.detailScreen,
      arguments: id,
    );
  }

  _closeBottomSheet() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBanner(),
        _buildBannerText(),
      ],
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
        color: AppColors.transparent,
        image: DecorationImage(
          fit: widget.homeScreenBloc.state.responseModel?.data['poster_path'] !=
                  null
              ? BoxFit.cover
              : BoxFit.contain,
          image:
              widget.homeScreenBloc.state.responseModel?.data['poster_path'] !=
                      null
                  ? NetworkImage(
                      '${AppStrings.imagePath}${widget.homeScreenBloc.state.responseModel?.data['poster_path']}',
                    )
                  : const NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
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
          color: AppColors.white,
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              AppColors.grey.withOpacity(0.0),
              AppColors.black,
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
        padding: const EdgeInsets.symmetric(horizontal: AppDimen.size20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildBannerGenreYear(),
            const SizedBox(
              height: AppDimen.size20,
            ),
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
            title: widget.homeScreenBloc.state.responseModel?.data['title'] ??
                AppStrings.noTitleFound,
            color: AppColors.white,
            fontSize: AppDimen.size16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.homeScreenBloc.state.responseModel?.data['release_date'] !=
                null &&
            widget.homeScreenBloc.state.responseModel?.data['release_date'] !=
                '')
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: AppDimen.size10,
              ),
              CustomText(
                title: CommonFunctions().getYearFromDate(widget
                    .homeScreenBloc.state.responseModel?.data['release_date']),
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
    return GestureDetector(
      onTap: () {
        CustomSnackbar.showSnackBar(
            context: context,
            message: 'My List Clicked!',
            backgroundColor: AppColors.blue);
      },
      child: Column(
        children: const [
          Icon(
            Icons.add,
            color: AppColors.white,
          ),
          SizedBox(
            height: AppDimen.size10,
          ),
          CustomText(
            title: AppStrings.myList,
            color: AppColors.white,
          )
        ],
      ),
    );
  }

  _buildBannerPlay() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.white)),
      onPressed: () {
        _navigateToDetailScreen(
            widget.homeScreenBloc.state.responseModel?.data['id']);
      },
      child: Row(
        children: const [
          Icon(Icons.play_arrow, color: AppColors.black),
          CustomText(
            title: AppStrings.play,
            fontSize: AppDimen.size16,
          ),
        ],
      ),
    );
  }

  _buildBannerInfo() {
    return GestureDetector(
      onTap: () {
        _buildBottomSheet();
      },
      child: Column(
        children: const [
          Icon(
            Icons.info_outline,
            color: AppColors.white,
          ),
          SizedBox(
            height: AppDimen.size10,
          ),
          CustomText(
            title: AppStrings.info,
            color: AppColors.white,
          )
        ],
      ),
    );
  }

  _buildBottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.size20)),
      builder: (builder) {
        return Container(
          constraints: const BoxConstraints(maxHeight: AppDimen.size350),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimen.size10),
              topRight: Radius.circular(AppDimen.size10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimen.size16),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildBottomSheetView(),
                _buildBottomSheetPlayDownloadMyListShare(),
                const Divider(),
                _buildBottomSheetDetailMore(),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildBottomSheetView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: AppDimen.size140,
          width: AppDimen.size100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.homeScreenBloc.state.responseModel
                          ?.data['poster_path'] !=
                      null
                  ? NetworkImage(
                      '${AppStrings.imagePath}${widget.homeScreenBloc.state.responseModel?.data['poster_path']}',
                    )
                  : const NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                    ),
              fit: widget.homeScreenBloc.state.responseModel
                          ?.data['poster_path'] !=
                      null
                  ? BoxFit.cover
                  : BoxFit.contain,
            ),
            color: AppColors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(AppDimen.size14),
            ),
          ),
        ),
        _buildBottomSheetDetail(),
      ],
    );
  }

  _buildBottomSheetDetail() {
    return Container(
      constraints: const BoxConstraints(maxWidth: AppDimen.size250),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBottomSheetMovieNameCancel(),
          const SizedBox(
            height: AppDimen.size10,
          ),
          _buildBottomSheetDateTime(),
          const SizedBox(
            height: AppDimen.size10,
          ),
          CustomText(
            title:
                widget.homeScreenBloc.state.responseModel?.data['overview'] ??
                    AppStrings.noDescriptionFound,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  _buildBottomSheetMovieNameCancel() {
    return Container(
      constraints: const BoxConstraints(maxWidth: AppDimen.size250),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomText(
              title: widget.homeScreenBloc.state.responseModel?.data['title'] ??
                  AppStrings.noTitleFound,
              fontSize: AppDimen.size20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: AppDimen.size20,
          ),
          IconButton(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(1),
            onPressed: () {
              _closeBottomSheet();
            },
            icon: const Icon(
              Icons.cancel,
            ),
          ),
        ],
      ),
    );
  }

  _buildBottomSheetDateTime() {
    return Row(
      children: [
        if (widget.homeScreenBloc.state.responseModel?.data['release_date'] !=
                null &&
            widget.homeScreenBloc.state.responseModel?.data['release_date'] !=
                '')
          CustomText(
              title: CommonFunctions().getYearFromDate(widget
                  .homeScreenBloc.state.responseModel?.data['release_date'])),
        if (widget.homeScreenBloc.state.responseModel?.data['release_date'] !=
                null &&
            widget.homeScreenBloc.state.responseModel?.data['release_date'] !=
                '')
          const SizedBox(
            width: AppDimen.size10,
          ),
        CustomText(
          title: widget.homeScreenBloc.state.responseModel?.data['runtime'] > 30
              ? CommonFunctions().durationToString(
                  widget.homeScreenBloc.state.responseModel?.data['runtime'])
              : '${widget.homeScreenBloc.state.responseModel?.data['runtime']} mins',
        ),
      ],
    );
  }

  _buildBottomSheetPlayDownloadMyListShare() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimen.size10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: AppDimen.size20,
                backgroundColor: AppColors.black.withOpacity(0.5),
                child: IconButton(
                  color: AppColors.white,
                  onPressed: () {
                    _closeBottomSheet();
                    _navigateToDetailScreen(
                        widget.homeScreenBloc.state.responseModel?.data['id']);
                  },
                  icon: const Icon(Icons.play_arrow),
                ),
              ),
              const SizedBox(
                height: AppDimen.size10,
              ),
              const CustomText(
                title: AppStrings.play,
              )
            ],
          ),
          Column(
            children: [
              CircleAvatar(
                radius: AppDimen.size20,
                backgroundColor: AppColors.black.withOpacity(0.5),
                child: IconButton(
                  color: AppColors.white,
                  onPressed: () {
                    CustomSnackbar.showSnackBar(
                        context: context,
                        message: 'Download Clicked!',
                        backgroundColor: AppColors.blue);
                  },
                  icon: const Icon(Icons.download),
                ),
              ),
              const SizedBox(
                height: AppDimen.size10,
              ),
              const CustomText(
                title: AppStrings.download,
              )
            ],
          ),
          Column(
            children: [
              CircleAvatar(
                radius: AppDimen.size20,
                backgroundColor: AppColors.black.withOpacity(0.5),
                child: IconButton(
                  color: AppColors.white,
                  onPressed: () {
                    CustomSnackbar.showSnackBar(
                        context: context,
                        message: 'My List Clicked!',
                        backgroundColor: AppColors.blue);
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
              const SizedBox(
                height: AppDimen.size10,
              ),
              const CustomText(
                title: AppStrings.myList,
              )
            ],
          ),
          Column(
            children: [
              CircleAvatar(
                radius: AppDimen.size20,
                backgroundColor: AppColors.black.withOpacity(0.5),
                child: IconButton(
                  color: AppColors.white,
                  onPressed: () {
                    CustomSnackbar.showSnackBar(
                        context: context,
                        message: 'Share Clicked!',
                        backgroundColor: AppColors.blue);
                  },
                  icon: const Icon(Icons.share),
                ),
              ),
              const SizedBox(
                height: AppDimen.size10,
              ),
              const CustomText(
                title: AppStrings.share,
              )
            ],
          ),
        ],
      ),
    );
  }

  _buildBottomSheetDetailMore() {
    return GestureDetector(
      onTap: () {
        _closeBottomSheet();
        _navigateToDetailScreen(
            widget.homeScreenBloc.state.responseModel?.data['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(AppDimen.size10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.info_outline,
                ),
                SizedBox(
                  width: AppDimen.size10,
                ),
                CustomText(
                  title: 'Details & More',
                  fontSize: AppDimen.size16,
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}
