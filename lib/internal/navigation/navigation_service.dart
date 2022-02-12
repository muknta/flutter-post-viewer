import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(
    String routeName, {
    Map<String, dynamic>? arguments,
  }) =>
      navigatorKey.currentState!.pushNamed(
        routeName,
        arguments: arguments,
      );
}
