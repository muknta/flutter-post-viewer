import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_viewer/internal/locator.dart';
import 'package:page_viewer/internal/logger.dart';
import 'package:page_viewer/internal/navigation/navigation.dart';
import 'package:page_viewer/presentation/blocs/post_viewer_bloc/post_viewer_bloc.dart';
import 'package:page_viewer/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:page_viewer/presentation/pages/home_page/home_page.dart';
import 'package:page_viewer/presentation/widgets/simplifiers/loader.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<PostViewerBloc>(
            create: (_) => PostViewerBloc(),
            dispose: (_, postBloc) => postBloc.dispose(),
          ),
          Provider<ThemeBloc>(
            create: (_) => ThemeBloc(),
            dispose: (_, themeBloc) => themeBloc.dispose(),
          ),
        ],
        child: FutureBuilder<void>(
          // TODO: check if it still needed
          future: locator.allReady(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Loader();
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
        ),
      );
}
