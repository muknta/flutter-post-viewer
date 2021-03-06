import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/blocs/post_viewer_bloc/post_viewer_bloc.dart';
import 'package:page_viewer/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:page_viewer/presentation/widgets/buttons/load_posts_button.dart';
import 'package:page_viewer/presentation/widgets/buttons/try_again_button.dart';
import 'package:page_viewer/presentation/widgets/layout/main_scaffold.dart';
import 'package:page_viewer/presentation/widgets/layout/post_list_widget.dart';
import 'package:page_viewer/presentation/widgets/simplifiers/loader.dart';
import 'package:page_viewer/presentation/widgets/simplifiers/text_widget.dart';

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
                onPressed: () => _postBloc.addEvent(const TapOnLoadPostsButtonEvent()),
              );
            } else if (postState is ErrorWhileLoadingPostsState) {
              return TryAgainButton(
                onPressed: () => _postBloc.addEvent(const TapOnTryAgainButtonEvent()),
              );
            } else if (postState is LoadedPostsState) {
              return PostListWidget(postList: postState.posts);
            } else if (postState is LoadingStepAlertState) {
              return _TextAlertsWidget(stepAlertState: postState);
            }
            return const Loader();
          },
        ),
      );
}

class _TextAlertsWidget extends StatelessWidget {
  const _TextAlertsWidget({Key? key, required LoadingStepAlertState stepAlertState})
      : _stepAlertState = stepAlertState,
        super(key: key);

  final LoadingStepAlertState _stepAlertState;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Loader(),
            const SizedBox(height: 20.0),
            TextWidget(
              _stepAlertState.message,
              color: context.readBloc<ThemeBloc>().theme.mainTheme.loaderColor,
              fontSize: 18.0,
            ),
          ],
        ),
      );
}
