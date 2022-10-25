import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/helpers/app_state.dart';
import '../../../modules/home_screen/view_model/home_screen_model.dart';
import '../../../bloc/bloc.dart';
import '../../../utils/helpers/api_constants.dart';
import '../../../utils/helpers/api_list.dart';
import '../../../utils/helpers/response_model.dart';

class HomeScreenBloc extends Bloc<HomeScreenModel> {
  @override
  HomeScreenModel initDefaultValue() {
    return HomeScreenModel(index: 0, appState: AppState.initial);
  }

  updateIndex(int currentIndex) {
    state.index = currentIndex;
    emit(state);
  }

  getLatestMovieApi() async {
    state.appState = AppState.loading;
    emit(state);
    String url =
        '${APIConstants.baseUrl}${APIList.getLatestMovie}?api_key=${APIConstants.apiKey}&language=${APIConstants.language}';
    var data = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    if (data.statusCode == 200) {
      state.appState = AppState.success;
      state.responseModel = ResponseModel(
        statusCode: data.statusCode.toString(),
        statusMessage: data.reasonPhrase.toString(),
        data: jsonDecode(data.body),
      );
      getTrendingNowApi();
    } else {
      state.appState = AppState.failure;
    }
    emit(state);
  }

  getTrendingNowApi() async {
    List list = [];
    state.appState = AppState.loading;
    emit(state);
    String url =
        '${APIConstants.baseUrl}${APIList.getPopularMovie}?api_key=${APIConstants.apiKey}&language=${APIConstants.language}';
    var data = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    if (data.statusCode == 200) {
      state.appState = AppState.success;
      list.addAll(jsonDecode(data.body)['results']);
      state.trendingNowResponseModel = TrendingNowResponseModel(
        statusCode: data.statusCode.toString(),
        statusMessage: data.reasonPhrase.toString(),
        data: list,
      );
    } else {
      state.appState = AppState.failure;
    }
    emit(state);
  }
}
