import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/blocs/post_viewer_bloc/post_viewer_bloc.dart';
import 'package:page_viewer/presentation/utils/extensions/bloc_context_finder_extension.dart';
import 'package:page_viewer/presentation/widgets/main_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String title = 'Posts';

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
  Widget build(BuildContext context) => const MainScaffold(
        title: HomePage.title,
        // TODO: implement body
        body: SizedBox.shrink(),
      );
}
