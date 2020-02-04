import 'package:flutter_slider/core/utils.dart';
import 'package:flutter_slider/model/element_model.dart';

class SlideModel {
  final List<ElementModel> elements;
  final TextElement title;
  final String backgroundColor;
  final String transitionIn;
  final String src;
  final bool hasLogo;

  SlideModel({
    this.elements,
    this.title, 
    this.backgroundColor, 
    this.transitionIn,
    this.src, 
    this.hasLogo
  });

  static List<SlideModel> fromSliderJson(result) {
    var slides = result['slides'];
    var slideList = [];

    slides.forEach((it) {
      var slide = SlideModel(
        title: it['title'] != null ? createElement(it['title']) : null,
        backgroundColor: it['background_color'],
        elements: ElementModel.fromSlideJson(it),
        transitionIn: result['transition_in'],
        hasLogo: it['has_logo'] != null ? it['has_logo'] : true,
        src: it['src']
      );

      slideList.add(slide);
    });
    return slideList.cast<SlideModel>();
  }
}