import 'package:flutter/material.dart';

const String homeRoute = '/';
const String postRoute = '/post';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SizedBox.shrink(), //HomePage(),
      );
    case postRoute:
      {
        final postDetails = settings.arguments as Map<String, dynamic>?;
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: const SizedBox.shrink(), //PostPage(details: postDetails),
        );
      }
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}

PageRoute _getPageRoute({
  required String routeName,
  required Widget viewToShow,
}) =>
    MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow,
    );
