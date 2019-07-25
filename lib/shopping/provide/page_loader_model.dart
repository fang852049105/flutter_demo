import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/config/loader_state.dart';

class PageLoaderStateModel extends ChangeNotifier {
  LoaderState _loaderState = LoaderState.loading;
  String _failMsg = "";

  PageLoaderStateModel([LoaderState _loaderState]) {
    this._loaderState = _loaderState ?? LoaderState.loading;
  }

  void changeState(LoaderState loaderState, [String failMsg]) {
    this._loaderState = loaderState;
    this._failMsg = failMsg;
    notifyListeners();
  }

  LoaderState get loaderState => _loaderState;
  String get failMsg => _failMsg;

}