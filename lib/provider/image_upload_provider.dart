import 'package:an_agile_squad/enum/view_state.dart';
import 'package:flutter/widgets.dart';

//using state management functions to notify listeners of changes while image is being uploaded
class ImageUploadProvider with ChangeNotifier {
  ViewState _viewState = ViewState.IDLE;
  ViewState get getViewState => _viewState;

  void setToLoading() {
    _viewState = ViewState.LOADING;
    notifyListeners();
  }

  void setToIdle() {
    _viewState = ViewState.IDLE;
    notifyListeners();
  }
}