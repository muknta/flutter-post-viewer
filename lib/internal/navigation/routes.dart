import 'package:flutter/material.dart';
import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/presentation/pages/home_page/home_page.dart';
import 'package:page_viewer/presentation/pages/post_page/post_page.dart';

const String homeRoute = '/';
const String postRoute = '/post';
const String postRoutePostEntityArgument = 'post_entity';
const String postRouteCommentEntityListArgument = 'comment_entity_list';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const HomePage(),
      );
    case postRoute:
      {
        final postDetails = settings.arguments as Map<String, dynamic>;
        final PostEntity post = postDetails[postRoutePostEntityArgument];
        final List<CommentEntity> commentList = postDetails[postRouteCommentEntityListArgument];
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: PostPage(post: post, commentList: commentList),
        );
      }
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}

PageRoute _getPageRoute({
  required String routeName,
  required Widget viewToShow,
}) =>
    MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow,
    );
