import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/themes/i_buttons_theme.dart';

class ButtonsLightTheme implements IButtonsTheme {
  const ButtonsLightTheme();

  @override
  Color get backgroundColor => Colors.blueGrey;
  @override
  Color get foregroundColor => Colors.black;

  @override
  Color get pressedButtonBackgroundColor => Colors.blue;
}
