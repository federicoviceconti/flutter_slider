import 'package:flutter/material.dart';
import 'package:flutter_slider/core/widget/base_notifier.dart';
import 'package:flutter_slider/core/widget/loading_widget.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends BaseNotifier> extends StatefulWidget {
  final T model;
  final Function(T model) onModelInit;
  final Widget child;
  final Widget Function(BuildContext context, T value, Widget child)  consumerBuilder;

  BaseWidget({this.model, this.onModelInit, this.consumerBuilder, this.child});

  @override
  _BaseWidget<T> createState() => _BaseWidget<T>();
}

class _BaseWidget<T extends BaseNotifier> extends State<BaseWidget<T>> {
  T _model;

  @override
  void initState() {
    super.initState();
    _model = widget.model;

    if(widget.onModelInit != null) {
      widget.onModelInit(_model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => widget.model,
      child: Stack(
        children: <Widget>[
          Consumer<T>(builder: widget.consumerBuilder, child: widget.child),
          Consumer<T>(builder: _buildLoader)
        ],
      )
    );
  }

  Widget _buildLoader(BuildContext context, T value, Widget child) {
    return _model.busy ? LoadingWidget(show: value.busy) : Container();
  }
}