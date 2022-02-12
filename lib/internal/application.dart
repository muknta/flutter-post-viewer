import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_viewer/internal/locator.dart';
import 'package:page_viewer/internal/logger.dart';
import 'package:page_viewer/internal/navigation/navigation.dart';
import 'package:page_viewer/presentation/pages/home_page/home_page.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
    if (!isTablet()) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<void>(
        future: locator.allReady(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            // TODO: custom loader
            return const SizedBox.shrink(); //CustomLoader();
          }
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            navigatorKey: locator<NavigationService>().navigatorKey,
            onGenerateRoute: generateRoute,
            initialRoute: homeRoute,
            home: const HomePage(),
          );
        },
      );

  bool isTablet() {
    final Size size = window.physicalSize;
    final double ratio = window.devicePixelRatio;
    final double width = min(size.width / ratio, size.height / ratio);
    logInDebug(width.toString());
    return width > 600;
  }
}
