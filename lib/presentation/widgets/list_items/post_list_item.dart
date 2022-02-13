import 'package:flutter/material.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/presentation/blocs/post_viewer_bloc/post_viewer_bloc.dart';
import 'package:page_viewer/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:page_viewer/presentation/themes/i_post_list_theme.dart';
import 'package:page_viewer/presentation/widgets/simplifiers/text_widget.dart';

class PostListItem extends StatefulWidget {
  const PostListItem({
    Key? key,
    required PostEntity postEntity,
  })  : _postEntity = postEntity,
        super(key: key);

  final PostEntity _postEntity;

  @override
  State<PostListItem> createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
  late final IPostListTheme _postListTheme;
  late final PostViewerBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postListTheme = context.readBloc<ThemeBloc>().theme.postListTheme;
    _postBloc = context.readBloc<PostViewerBloc>();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () => _postBloc.addEvent(
            TapOnPostFromListEvent(postEntity: widget._postEntity),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _postListTheme.itemBackgroundColor,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: _postListTheme.itemShadowColor,
                  blurRadius: 0.0,
                  spreadRadius: 1.0,
                  offset: const Offset(2.0, 2.0),
                )
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: TextWidget(
                    widget._postEntity.id.toString(),
                    color: _postListTheme.itemTextColor,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(flex: 2),
                Expanded(
                  flex: 30,
                  child: TextWidget(
                    widget._postEntity.title,
                    color: _postListTheme.itemTextColor,
                    fontSize: 16,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
