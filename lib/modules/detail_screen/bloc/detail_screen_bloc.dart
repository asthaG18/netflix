import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../modules/detail_screen/view_model/detail_screen_view_model.dart';
import '../../../utils/helpers/app_state.dart';
import '../../../bloc/bloc.dart';
import '../../../utils/helpers/api_constants.dart';
import '../../../utils/helpers/api_list.dart';
import '../../../utils/helpers/response_model.dart';

class DetailScreenBloc extends Bloc<DetailScreenModel> {
  @override
  DetailScreenModel initDefaultValue() {
    return DetailScreenModel(
      index: 0,
      appState: AppState.initial,
    );
  }

  getMovieDetailApi(int id) async {
    state.appState = AppState.loading;
    emit(state);
    String url =
        '${APIConstants.baseUrl}${APIList.getMovieDetail}/$id?api_key=${APIConstants.apiKey}&language=${APIConstants.language}';
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
      state.appState = AppState.failure;
    }
    emit(state);
  }
}
