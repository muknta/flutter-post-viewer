import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/themes/i_buttons_theme.dart';

class ButtonsDarkTheme implements IButtonsTheme {
  const ButtonsDarkTheme();

  @override
  Color get backgroundColor => Colors.blueGrey;
  @override
  Color get foregroundColor => Colors.white;

  @override
  Color get pressedButtonBackgroundColor => Colors.blue;
}
