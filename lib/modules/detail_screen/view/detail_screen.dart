import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../bloc/bloc_builder.dart';
import '../../../utils/custom_widgets/custom_snackbar.dart';
import '../../../res/colors.dart';
import '../../../res/dimen.dart';
import '../../../res/strings.dart';
import '../../../utils/custom_widgets/custom_text.dart';
import '../../../utils/helpers/common_functions.dart';
import '../bloc/detail_screen_bloc.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final DetailScreenBloc _detailScreenBloc = DetailScreenBloc();

  _navigateBack() {
    Navigator.of(context).pop();
  }

  _launchURL(String url) async {
    Uri urlToLaunch = Uri.parse(url);
    if (await canLaunchUrl(urlToLaunch)) {
      await launchUrl(urlToLaunch);
    } else {
      throw "Could not launch $urlToLaunch";
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    _detailScreenBloc.getMovieDetailApi(id);
    return BlocBuilder(
        builder: () {
          return Scaffold(
            backgroundColor: AppColors.black,
            body: ListView(
              children: [
                Stack(
                  children: [
                    _buildBanner(),
                    _buildHeader(),
                    _buildBannerText(),
                  ],
                ),
                _buildDescription(),
              ],
            ),
          );
        },
        bloc: _detailScreenBloc);
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
          fit: BoxFit.cover,
          image:
              _detailScreenBloc.state.responseModel?.data['poster_path'] != null
                  ? NetworkImage(
                      '${AppStrings.imagePath}${_detailScreenBloc.state.responseModel?.data['poster_path']}',
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
            _buildBannerPlay(),
          ],
        ),
      ),
    );
  }

  _buildBannerGenreYear() {
    return Row(
      children: [
        Flexible(
          child: CustomText(
            title: _detailScreenBloc.state.responseModel?.data['title'] ??
                AppStrings.noTitleFound,
            color: AppColors.white,
            fontSize: AppDimen.size18,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: AppDimen.size10,
            ),
            CustomText(
              title:
                  _detailScreenBloc.state.responseModel?.data['release_date'] !=
                          null
                      ? CommonFunctions().getYearFromDate(_detailScreenBloc
                          .state.responseModel?.data['release_date'])
                      : '',
              color: AppColors.white,
              fontSize: AppDimen.size16,
            ),
          ],
        ),
      ],
    );
  }

  _buildBannerPlay() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.red)),
      onPressed: () {
        _launchURL(_detailScreenBloc.state.responseModel?.data['homepage']);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.play_arrow,
            color: AppColors.white,
          ),
          CustomText(
            title: AppStrings.play,
            fontSize: AppDimen.size16,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }

  _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            _navigateBack();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            CustomSnackbar.showSnackBar(
              context: context,
              message: 'My List Clicked!',
              backgroundColor: AppColors.blue,
            );
          },
          icon: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        )
      ],
    );
  }

  _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(AppDimen.size20),
      child: CustomText(
        title: _detailScreenBloc.state.responseModel?.data['overview'] ??
            AppStrings.noDescriptionFound,
        color: AppColors.white,
        fontSize: AppDimen.size16,
      ),
    );
  }
}
