import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider/core/constants.dart';
import 'package:flutter_slider/flutter_provider/lib/main.dart';
import 'package:flutter_slider/model/element_model.dart';
import 'package:flutter_slider/model/resolution.dart';
import 'package:flutter_slider/views/counter_example/counter.dart';

import 'widget/phone_frame.dart';

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  if(hexString != null && hexString.isNotEmpty) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  return Color(0xFFFFFF);
}

createElement(Map<String, dynamic> json) {
  var type = json != null ? json['type'] ?? "" : "";

  switch(type) {
    case ElementConstant.ANIMATION:
      AnimationElement animation = createAnimationElementFromJson(json);
      return commonProperty(animation, json);
    case ElementConstant.TEXT:
      TextElement text = createTextElementFromJson(json);
      return commonProperty(text, json);
    case ElementConstant.IMAGE:
      TextElement text = createTextElementFromJson(json['bottomText']);
      var image = ImageElement(
        src: json['src'],
        bottomText: text,
      );
      return commonProperty(image, json);
    case ElementConstant.APP:
      var app = AppElement(
        name: json['name']
      );
      return commonProperty(app, json);
  }

  return commonProperty(ElementModel(""), json);
}

AnimationElement createAnimationElementFromJson(Map<String, dynamic> json) {
  if(json != null) {
    return AnimationElement(
      name: json['name']
    );
  }

  return null;
}

TextElement createTextElementFromJson(Map<String, dynamic> json) {
  if(json != null) {
    return TextElement(
      json['content'],
      size: json['size'] != null ? json['size'].toDouble() : 12,
      color: json['color'],
      weight: json['weight'],
      textAlign: json['textAlign']
    );
  }
  
  return null;
}

commonProperty<T extends ElementModel>(T element, json) {
  element.elementType = json['type'];
  element.width = json['width']?.toDouble() ?? -1;
  element.height = json['height']?.toDouble() ?? -1;
  element.top = json['top']?.toDouble() ?? 0;
  element.left = json['left']?.toDouble() ?? 0;
  element.right = json['right']?.toDouble() ?? 0;
  element.bottom = json['bottom']?.toDouble() ?? 0;
  element.align = json['align'];
  element.marginTop = json['marginTop']?.toDouble() ?? 0;
  element.marginLeft = json['marginLeft']?.toDouble() ?? 0;
  element.marginRight = json['marginRight']?.toDouble() ?? 0;
  element.marginBottom = json['marginBottom']?.toDouble() ?? 0;
  element.backgroundColor = json['background_color'] ?? null;
  return element;
}

Widget createWidget(ElementModel model, ResolutionScreen resolution, Size query) {
  var type = model.elementType;
  Widget child = Container();

  //TODO make better
  resolution.currentResolution = Resolution(height: query.height.toInt(), width: query.width.toInt());

  switch(type) {
    case ElementConstant.TEXT:
      var text = model as TextElement;
      child = _buildSpan(text, resolution);
      break;
    case ElementConstant.IMAGE:
      var image = model as ImageElement;
      var bottomText = _shouldBuildBottomText(image, resolution, query);
      child = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: loadImage(image.src),
          ),
          bottomText
        ],
      );
      break;
    case ElementConstant.APP:
      var app = model as AppElement;
      child = createApp(app);
      break;
    case ElementConstant.ANIMATION:
      var anim = model as AnimationElement;
      child = createAnimation(anim);
      break;
    default:
      child = Container();
  }

  child = _buildWidgetDimensions(child, resolution, height: model?.height, width: model?.width);
  child = _buildCommonProperty(model, child, resolution);
  child = _buildAlign(model.align, child);
  child = _buildMargin(model, child, resolution);
  return child;
}

_shouldBuildBottomText(ImageElement image, ResolutionScreen resolutionScreen, Size size) {
  var bottom = image.bottomText;
  if(bottom != null && bottom.content.isNotEmpty) {
    return Flexible(
      child: Container(
        alignment: Alignment.center,
        child: _buildBottomText(image.bottomText, resolutionScreen, size),
      ),
    );
  }

  return Container();
}

Widget createAnimation(AnimationElement anim) {
  return FlareActor("assets/animations/${anim.name}", fit:BoxFit.contain, animation:"idle");
}

Widget createApp(AppElement app) {
  if(app.name == "provider") {
    var provider = ClipRect(
      child: FlutterProvider()
    );
    return provider;
  }

  var counter = CounterExample();
  return counter;
}

Widget _buildSpan(TextElement text, ResolutionScreen resolution) {
  var weight = text.weight != null ? FontWeight.values.firstWhere((it) => it.toString() == text.weight, orElse: () => FontWeight.normal) : FontWeight.normal;
  var textAlign = text.textAlign != null ? TextAlign.values.firstWhere((it) {
    return it.toString() == "TextAlign.${text.textAlign}";
  }) : TextAlign.left;
  var size = text.size != null ? text.size : 30.0;

  List<TextSpan> textList = [];
  int startSpan = 0;
  
  while(startSpan > -1 && startSpan < text.content.length) {
    var tupla = _buildSpannedText(text, 
      startSpan: startSpan, 
      tagStart: "<b>", 
      tagEnd: "</b>",
      accentColor: "#D5FD58"
    );
    startSpan = tupla.third;

    textList.add(TextSpan(
      text: tupla.first, 
      style: TextStyle(
        color: hexToColor(tupla.second)
      )
    ));
  }
  return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: TextStyle(
          fontFamily: "FuturaPT",
          fontWeight: weight,
          fontSize: resolution.getDimen(size, 'w')
        ),
        children: textList
      ),
    );
}

//TODO very important: make better!
/// This method created a spanned text for child in slide
/// The slide json has some tags that we use to identify the special part, like: "<b></b>"
Tuple<String, String, int> _buildSpannedText(TextElement text, {int startSpan, String tagStart, String tagEnd, String accentColor}) {
    var textSpan = text.content;
    var color = text.color;
    var bold = text.content.indexOf(tagStart, startSpan);
    var endBold = text.content.indexOf(tagEnd, startSpan);
    
    if(endBold == -1 && bold == -1 && startSpan > 0) {
      var startIdx = startSpan + 3;
      var endIdx = text.content.length;
      textSpan = text.content.substring(startIdx, endIdx);
      color = text.color;
      startSpan = -1;
    } if(endBold == -1 && bold == -1 && startSpan == 0) {
      textSpan = text.content;
      color = text.color;
      startSpan = -1;
    } else if(bold == -1 && endBold > -1) {
      var startIdx = startSpan + 2;
      var endIdx = text.content.indexOf(tagEnd, startSpan);
      textSpan = text.content.substring(startIdx, endIdx);
      color = accentColor;
      startSpan = endIdx + 1;
    } else if(endBold == -1 && bold > -1) {
      var startIdx = text.content.indexOf(tagEnd, startSpan);
      var endIdx = text.content.length - 1;
      textSpan = text.content.substring(startIdx, endIdx);
      color = accentColor;
      startSpan = -1;
    } else if(bold < endBold && startSpan <= bold) {
      var startIdx = startSpan;
      var endIdx = text.content.indexOf(tagStart, startSpan);
      textSpan = text.content.substring(startIdx, endIdx);
      color = text.color;
      startSpan = text.content.indexOf(tagStart, startSpan) + 1;
    } else if(endBold < bold) {
      var endIdx = text.content.indexOf(tagEnd, startSpan);
      textSpan = text.content.substring(startSpan + 2, endIdx);
      color = accentColor;
      startSpan = text.content.indexOf(tagEnd, startSpan) + 4;
    }
    
    textSpan = textSpan.replaceAll(tagEnd, "");
    textSpan = textSpan.replaceAll(tagStart, "");
    return Tuple(textSpan, color, startSpan);
}

_buildBottomText(TextElement text, ResolutionScreen resolution, Size query) {
  if(text != null) {
    return createWidget(text, resolution, query);
  }

  return Container();
}

Widget _buildMargin(ElementModel model, Widget widget, ResolutionScreen resolution) {
  double top = model.marginTop; 
  double right = model.marginRight;
  double bottom = model.marginBottom; 
  double left = model.marginLeft;

  return Container(
    padding: EdgeInsets.only(
      top: resolution.getDimen(top, 'h'),
      left: resolution.getDimen(left, 'w'),
      right: resolution.getDimen(right, 'w'),
      bottom: resolution.getDimen(bottom, 'h')
    ),
    child: widget,
  );
}

Widget _buildAlign(String align, Widget widget) {
  if(align != null && align.isNotEmpty) {
    return Align(
      alignment: _getAlignFromString(align),
      child: widget,
    );
  }

  return widget;
}

Alignment _getAlignFromString(String align) {
  switch(align) {
    case "top":
    case "top|center":
      return Alignment.topCenter;
    case "top|left":
      return Alignment.topLeft;
    case "top|right":
      return Alignment.topRight;
    case "center":
      return Alignment.center;
    case "center|left":
      return Alignment.centerLeft;
    case "center|right":
      return Alignment.centerRight;
    case "bottom":
    case "bottom|center":
      return Alignment.bottomCenter;
    case "bottom|left":
      return Alignment.bottomLeft;
    case "bottom|right":
      return Alignment.bottomRight;
  }

  return Alignment.topLeft;
}

Widget _buildCommonProperty(ElementModel model, Widget widget, ResolutionScreen resolution) {
  double top = model.top; 
  double right = model.right;
  double bottom = model.bottom; 
  double left = model.left;

  var color = hexToColor(model.backgroundColor);
  var edgeInset = EdgeInsets.only(
    top: resolution.getDimen(top, 'h'),
    left: resolution.getDimen(left, 'w'),
    right: resolution.getDimen(right, 'w'),
    bottom: resolution.getDimen(bottom, 'h')
  );

  return !hasShape(model) ? Container(
    color: color,
    padding: edgeInset,
    child: widget,
  ) : Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color
    ),
    padding: edgeInset,
    child: widget,
  );
}

bool hasShape(ElementModel model) => false; //TODO

Widget _buildWidgetDimensions(Widget widget, ResolutionScreen resolution, {double height = -1, double width = -1}) {
  if(isDimensionValid(width) && isDimensionValid(height)) {
    return Container(
      width: resolution.getDimen(width, 'w'),
      height: resolution.getDimen(height, 'h'),
      child: widget
    );
  } else if(isDimensionValid(height)) {
    return Container(
      height: resolution.getDimen(height, 'h'),
      child: widget
    );
  } else if(isDimensionValid(width)) {
    return Container(
      width: resolution.getDimen(width, 'w'),
      child: widget
    );
  } else if(width == -2 && height == -2) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: widget
    );
  } else if(height == -2) {
    return Container(
      height: double.infinity,
      child: widget
    );
  } else if(width == -2) {
    return Container(
      width: double.infinity,
      child: widget
    );
  }

  return Container(
    child: widget
  );
}

bool isDimensionValid(double dim) {
  return dim != null && dim > -1;
}

getCurve(String animation) {
  switch(animation) {
    case 'ease_out':
      return Curves.easeOut;
    case 'ease_in':
    default:
      return Curves.easeIn;
  }
}

Widget loadImage(String source) {
  if(source == null || source.isEmpty) {
    return Container();
  }
  if(source.startsWith("http") || source.startsWith("ftp")) {
    return Image.network(source);
  } else {
    return Container(
      child: Image.asset("assets/images/$source"),
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class Tuple<T, R, S> {
  T first;
  R second;
  S third;

  Tuple(this.first, this.second, this.third);
}