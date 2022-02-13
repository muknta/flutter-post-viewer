import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/themes/dark_themes/main_dark_theme.dart';
import 'package:page_viewer/presentation/themes/i_main_theme.dart';
import 'package:page_viewer/presentation/themes/i_theme.dart';

class DarkTheme implements ITheme {
  const DarkTheme();

  @override
  IMainTheme get mainTheme => const MainDarkTheme();
}
