import 'package:flutter/material.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/presentation/blocs/post_viewer_bloc/post_viewer_bloc.dart';
import 'package:page_viewer/presentation/widgets/layout/main_scaffold.dart';

class PostPage extends StatefulWidget {
  PostPage({Key? key, required PostEntity postEntity})
      : _postEntity = postEntity,
        _title = 'Post ${postEntity.id}',
        super(key: key);

  final PostEntity _postEntity;
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
