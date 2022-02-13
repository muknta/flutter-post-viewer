import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/themes/i_post_list_theme.dart';

class PostListDarkTheme implements IPostListTheme {
  const PostListDarkTheme();

  @override
  Color get itemBackgroundColor => Colors.white;

  @override
  Color get itemTextColor => Colors.black;

  @override
  Color get itemShadowColor => Colors.grey;
  @override
  double get itemShadowBlurRadius => 3.0;
  @override
  double get itemShadowSpreadRadius => 3.0;

  @override
  double get itemBorderRadius => 5.0;
}
