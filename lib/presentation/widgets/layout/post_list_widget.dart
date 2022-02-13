import 'package:flutter/material.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:page_viewer/presentation/themes/i_post_list_theme.dart';
import 'package:page_viewer/presentation/widgets/list_items/post_list_item.dart';

class PostListWidget extends StatefulWidget {
  const PostListWidget({
    Key? key,
    required List<PostEntity> postList,
  })  : _postList = postList,
        super(key: key);

  final List<PostEntity> _postList;

  @override
  State<PostListWidget> createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {
  late final IPostListTheme _postListTheme;

  @override
  void initState() {
    super.initState();
    _postListTheme = context.readBloc<ThemeBloc>().theme.postListTheme;
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: widget._postList.length,
        itemBuilder: (context, index) => PostListItem(
          postEntity: widget._postList.elementAt(index),
        ),
      );
}
