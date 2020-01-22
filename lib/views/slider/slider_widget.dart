import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider/core/config.dart';
import 'package:flutter_slider/core/utils.dart';
import 'package:flutter_slider/core/widget/base_widget.dart';
import 'package:flutter_slider/services/slider_service.dart';
import 'package:flutter_slider/views/slide/slide_widget.dart';
import 'package:flutter_slider/views/slider/slider_notifier.dart';
import 'package:provider/provider.dart';

class SliderWidget extends StatelessWidget {
  final _pageController = PageController(initialPage: 0);
  final bool showRefreshButton;

  SliderWidget({this.showRefreshButton = true});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SliderNotifier>(
      model: SliderNotifier(
        service: Provider.of<SliderService>(context, listen: false),
        //resolution: Resolution(width: query.width.toInt(), height: query.height.toInt())
      ),
      onModelInit: (model) => model.onModelInit(),
      consumerBuilder: (_, SliderNotifier model, __) => RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (key) => _onKeyPressed(key, context, model),
        child: Stack(
          children: <Widget>[
            _buildBackgroundColor(model),
            PageView(
              controller: _pageController,
              children: _buildSlider(model),
            ),
            _buildRefresh(model)
          ],
        ),
      ),
    );
  }

  _buildSlider(SliderNotifier model) {
    if(model != null && model.slider != null)
      return model.slider.slides.map((it) => SlideWidget(slide: it)).toList();

    return [Container()];
  }

  _buildBackgroundColor(SliderNotifier model) {
    if(model != null && model.slider != null && model.slider.backgroundColor != null)
      return Container(
        height: double.infinity,
        width: double.infinity,
        color: hexToColor(model.slider.backgroundColor),
      );

    return Container();
  }

  void _onKeyPressed(RawKeyEvent event, BuildContext context, SliderNotifier notifier) {
    int keyCode;
    
    switch (event.data.runtimeType) {
      case RawKeyEventDataMacOs:
        final RawKeyEventDataMacOs data = event.data;
        keyCode = data.keyCode;
        var slider = notifier?.slider;
        if(slider != null) {
          var transitionIn = slider?.slides[_pageController.page.toInt()]?.transitionIn;
          var length = slider.slides.length - 1 ?? 0;
          
          if (keyCode == KeyCode.right && _pageController.page < length) {
            _pageController?.nextPage(duration: Duration(milliseconds: 500), curve: getCurve(transitionIn));
          } else if (keyCode == KeyCode.left && _pageController.page > 0) {
            _pageController?.previousPage(duration: Duration(milliseconds: 500), curve: getCurve(transitionIn));
          } else if (keyCode == KeyCode.r) {
            notifier.onModelInit();
          } else if(keyCode == KeyCode.f) {
            fullscreen();
          }
        }
        break;
      default:
        throw new Exception('Unsupported platform');
    }
  }

  _buildRefresh(SliderNotifier model) {
    return showRefreshButton ? Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            model.onModelInit();
          },
        ),
      ),
    ) : Container() ;
  }

  Future<void> fullscreen() async {
  }
}