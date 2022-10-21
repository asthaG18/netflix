import '../../../utils/helpers/app_state.dart';
import '../../../utils/helpers/response_model.dart';

class HomeScreenModel {
  int index;
  AppState appState;
  ResponseModel? responseModel;

  HomeScreenModel(
      {required this.index, required this.appState, this.responseModel});
}
