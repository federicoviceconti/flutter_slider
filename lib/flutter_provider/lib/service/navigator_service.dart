import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, Object arguments) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }
}