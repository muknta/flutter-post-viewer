import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/blocs/post_viewer_bloc/post_viewer_bloc.dart';
import 'package:page_viewer/presentation/widgets/buttons/load_posts_button.dart';
import 'package:page_viewer/presentation/widgets/buttons/try_again_button.dart';
import 'package:page_viewer/presentation/widgets/layout/main_scaffold.dart';
import 'package:page_viewer/presentation/widgets/layout/post_list_widget.dart';
import 'package:page_viewer/presentation/widgets/simplifiers/loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String _title = 'Posts';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PostViewerBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = context.readBloc<PostViewerBloc>();
  }

  @override
  Widget build(BuildContext context) => MainScaffold(
        title: HomePage._title,
        body: StreamBuilder<PostViewerState>(
          stream: _postBloc.postStateStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Loader();
            }
            final PostViewerState postState = snapshot.data!;
            if (postState is PostsNotFoundState) {
              return LoadPostsButton(
                onPressed: () => _postBloc.addEvent(const TapOnLoadPostsEvent()),
              );
            } else if (postState is ErrorWhileLoadingPostsState) {
              return TryAgainButton(
                onPressed: () => _postBloc.addEvent(const TapOnLoadPostsEvent()),
              );
            } else if (postState is LoadedPostsState) {
              return PostListWidget(postList: postState.posts);
            }
            return const Loader();
          },
        ),
      );
}
