import 'package:flutter/material.dart';
import 'package:flutter_slider/core/utils.dart';
import 'package:flutter_slider/model/element_model.dart';
import 'package:flutter_slider/model/slide_model.dart';
import 'package:flutter_slider/views/slider/slider_notifier.dart';
import 'package:provider/provider.dart';

class SlideWidget extends StatelessWidget {
  final SlideModel slide;

  const SlideWidget({Key key, this.slide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSlide(slide, context);
  }

  Widget _buildSlide(SlideModel model, BuildContext context) {
    return Container(
      color: hexToColor(model.backgroundColor),
      width: double.infinity,
      height: double.infinity,
      child: _buildSlideTemplate(model, context),
    );
  }

  _buildSlideTemplate(SlideModel model, BuildContext context) {
    var elements = _buildElements(model.elements, context);
    var notifier = Provider.of<SliderNotifier>(context);
    var size = MediaQuery.of(context).size;

    return _hasTitle(model) ? Stack(
      children: [
        _buildBackground(context, model),
        Container(
          width: double.infinity, 
          child: createWidget(model.title, notifier.slider.resolutionScreen, size)
        ),
        Container(
          width: double.infinity, 
          child: Stack(children: elements)
        ),
      ],
    ) : Stack(
      children: [
        _buildBackground(context, model),
        Container(
          width: double.infinity, 
          child: Stack(children: elements)
        ),
      ],
    );
  }
      
  List<Widget> _buildElements(List<ElementModel> elements, BuildContext context) {
    var notifier = Provider.of<SliderNotifier>(context);
    var size = MediaQuery.of(context).size;

    return elements.map((it) => createWidget(it, notifier.slider.resolutionScreen, size)).toList();
  }

  _hasTitle(SlideModel model) => model.title != null && model.title.isNotEmpty();

  _buildBackground(BuildContext context, SlideModel model) {
    var notifier = Provider.of<SliderNotifier>(context);

    if(notifier.slider != null && model.src != null && model.src.isNotEmpty) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: loadImage(model.src),
      );
    }

    return Container();
  }
}