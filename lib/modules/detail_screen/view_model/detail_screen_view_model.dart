import '../../../utils/helpers/app_state.dart';
import '../../../utils/helpers/response_model.dart';

class DetailScreenModel {
  int index;
  AppState appState;
  ResponseModel? responseModel;

  DetailScreenModel({
    required this.index,
    required this.appState,
    this.responseModel,
  });
}
