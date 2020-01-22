import 'package:flutter/material.dart';
import 'package:flutter_slider/model/slider_model.dart';
import 'package:flutter_slider/services/api.dart';
import 'dart:convert';
import 'base_service.dart';

class SliderService extends BaseService {
  SliderService({@required Api api}) : super(api);

  Future<SliderModel> getSlides() {
    return api.getSlide().then((it) {
      if(isOk(it))
        return SliderModel.fromJson(jsonDecode(it.body));

      throw Error();
    });
  }
}