import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/themes/i_main_theme.dart';

class MainDarkTheme implements IMainTheme {
  const MainDarkTheme();

  @override
  Color get backgroundColor => Colors.grey;

  @override
  Color get appBarBackgroundColor => Colors.black;
  @override
  Color get appBarTextColor => Colors.white;
}
