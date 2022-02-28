import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/themes/i_main_theme.dart';

class MainLightTheme implements IMainTheme {
  const MainLightTheme();

  @override
  Color get backgroundColor => Colors.white;

  @override
  Color get appBarBackgroundColor => Colors.blueGrey;
  @override
  Color get appBarTextColor => Colors.black;

  @override
  Color get loaderColor => Colors.black;
}
