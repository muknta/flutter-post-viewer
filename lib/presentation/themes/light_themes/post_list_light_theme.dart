import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/themes/i_post_list_theme.dart';

class PostListLightTheme implements IPostListTheme {
  const PostListLightTheme();

  @override
  Color get itemBackgroundColor => Colors.blueGrey;

  @override
  Color get itemTextColor => Colors.black;

  @override
  Color get itemShadowColor => Colors.black;
}
