import 'package:flutter_slider/model/author_model.dart';
import 'package:flutter_slider/model/resolution.dart';
import 'package:flutter_slider/model/slide_model.dart';

class SliderModel {
  final String title;
  final ResolutionScreen resolutionScreen;
  final List<SlideModel> slides;
  final String description;
  final List<Author> authors;
  final String backgroundColor;

  SliderModel({this.title, this.backgroundColor, this.resolutionScreen, this.slides, this.description, this.authors});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    var result = json['result'];

    return SliderModel(
      title: result['title'],
      description: result['description'],
      backgroundColor: result['background_color'],
      resolutionScreen: ResolutionScreen.fromSliderJson(result),
      authors: Author.fromSliderJson(result),
      slides: SlideModel.fromSliderJson(result)
    );
  }
}