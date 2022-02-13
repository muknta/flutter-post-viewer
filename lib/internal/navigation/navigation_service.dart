import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
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
