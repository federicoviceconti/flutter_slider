import 'package:flutter_slider/core/constants.dart';
import 'package:flutter_slider/core/utils.dart';

class ElementModel {
  String elementType;
  double width = -1, height = -1;
  double top, left, right, bottom;
  String align;
  String backgroundColor;
  double marginBottom;
  double marginLeft;
  double marginRight;
  double marginTop;

  ElementModel.create(this.elementType);

  ElementModel(this.elementType, {
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.width,
    this.height,
    this.align,
    this.marginTop,
    this.marginRight,
    this.marginLeft,
    this.marginBottom,
    this.backgroundColor
  });

  static List<ElementModel> fromSlideJson(result) {
    var elementList = [];
    
    result['elements'].forEach((element) {
      var current = createElement(element);
      elementList.add(current);
    });

    return elementList.cast<ElementModel>();
  }
}

class TextElement extends ElementModel {
  final String content;
  final String color;
  final String weight;
  final double size;
  final String textAlign;
  final String accentColor;

  TextElement(this.content, { 
    this.size,
    this.color, 
    this.weight, 
    this.textAlign,
    this.accentColor
  }) : super(ElementConstant.TEXT);

  bool isNotEmpty() {
    return content != null && content.isNotEmpty;
  }
}

class ImageElement extends ElementModel {
  final String src;
  final TextElement bottomText;
  final bool shouldFlexBottom;

  ImageElement({this.src, this.bottomText, this.shouldFlexBottom = true}) : super(ElementConstant.IMAGE);
}

class AppElement extends ElementModel {
  final String name;

  AppElement({this.name}) : super(ElementConstant.APP);
}

class AnimationElement extends ElementModel {
  final String name;

  AnimationElement({this.name}) : super(ElementConstant.ANIMATION);
}