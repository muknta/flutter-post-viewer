import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/themes/i_post_list_theme.dart';

class PostListDarkTheme implements IPostListTheme {
  const PostListDarkTheme();

  @override
  Color get itemBackgroundColor => Colors.blueGrey;

  @override
  Color get itemTextColor => Colors.white;

  @override
  Color get itemShadowColor => Colors.white;
}
