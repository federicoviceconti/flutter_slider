
import 'package:flutter/material.dart';
import 'package:flutter_slider/core/widget/base_notifier.dart';

import 'package:flutter_slider/model/slider_model.dart';
import 'package:flutter_slider/services/slider_service.dart';

class SliderNotifier extends BaseNotifier {
  SliderModel _model;
  SliderService service;

  SliderNotifier({@required this.service});

  SliderModel get slider => _model;

  void onModelInit() {
    showLoader(true);
    
    service
      .getSlides()
      .then((it) {
        if(it != null) {
          _model = it;
        }

        showLoader(false);
      })
      .catchError((err) {
        showLoader(false);
      });
  }

  void onKeyboardPressed(int keyId) {
  }
}