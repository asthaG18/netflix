import 'package:netflix/modules/home_screen/list/show_type_list_model.dart';
import '../../../res/strings.dart';

class ShowTypeList {
  static final List<ShowTypeListModel> list = [
    ShowTypeListModel(
      AppStrings.tvShows,
      'https://images.hindustantimes.com/img/2021/08/31/1600x900/money_heist_1630404155391_1630404163247.jpg',
    ),
    ShowTypeListModel(
      AppStrings.movies,
      'https://cdn.mos.cms.futurecdn.net/KfC9Tu3E75tMxhcrBVz6wb.jpg',
    ),
  ];
}
