import 'package:flutter/material.dart';
import 'package:flutter_slider/core/provider_setup.dart';
import 'package:flutter_slider/views/slider/slider_widget.dart';
import 'package:provider/provider.dart';

import 'core/config.dart';
import 'services/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slides',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Muli'
      ),
      home: MultiProvider(
        providers: setupProviderServices(),
        child: Scaffold(body: SliderWidget(showRefreshButton: Config.environment != Environment.MOCK))
      ),
    );
  }
}