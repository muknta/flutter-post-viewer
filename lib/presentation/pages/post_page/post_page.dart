import 'package:flutter/material.dart';
import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/presentation/blocs/post_viewer_bloc/post_viewer_bloc.dart';
import 'package:page_viewer/presentation/widgets/layout/main_scaffold.dart';

class PostPage extends StatefulWidget {
  PostPage({Key? key, required PostEntity post, required List<CommentEntity> commentList})
      : _post = post,
        _commentList = commentList,
        _title = 'Post ${post.id}',
        super(key: key);

  final PostEntity _post;
  final List<CommentEntity> _commentList;
  final String _title;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late final PostViewerBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = context.readBloc<PostViewerBloc>();
  }

  @override
  Widget build(BuildContext context) => MainScaffold(
        onBackButtonTap: () => _postBloc.addEvent(const TapOnBackButtonFromPostPageEvent()),
        title: widget._title,
        // TODO: implement body
        body: const SizedBox.shrink(),
      );
}
