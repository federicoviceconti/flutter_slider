import 'package:flutter/material.dart';

abstract class BaseNotifier with ChangeNotifier {
  void onModelInit();

  bool _busy = false;
  bool get busy => _busy;

  void showLoader(shouldShow) {
    _busy = shouldShow;
    notifyListeners();
  }
}