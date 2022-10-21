import 'package:flutter/material.dart';
import '../../../modules/home_screen/list/bottom_tab_list_model.dart';
import '../../../res/colors.dart';
import '../../../res/strings.dart';

class BottomTabList {
  static final List<BottomTabListModel> list = [
    BottomTabListModel(
      const Icon(Icons.home),
      AppStrings.home,
      AppColors.black,
    ),
    BottomTabListModel(
      const Icon(Icons.gamepad_rounded),
      AppStrings.games,
      AppColors.black,
    ),
    BottomTabListModel(
      const Icon(Icons.fireplace_sharp),
      AppStrings.hotNew,
      AppColors.black,
    ),
    BottomTabListModel(
      const Icon(Icons.emoji_emotions_outlined),
      AppStrings.fastLaughs,
      AppColors.black,
    ),
    BottomTabListModel(
      const Icon(Icons.download_rounded),
      AppStrings.downloads,
      AppColors.black,
    ),
  ];
}
