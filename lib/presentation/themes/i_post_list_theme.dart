import 'package:flutter/material.dart';

abstract class IPostListTheme {
  const IPostListTheme();

  Color get itemBackgroundColor;

  Color get itemTextColor;

  Color get itemShadowColor;
  double get itemShadowBlurRadius;
  double get itemShadowSpreadRadius;

  double get itemBorderRadius;
}
