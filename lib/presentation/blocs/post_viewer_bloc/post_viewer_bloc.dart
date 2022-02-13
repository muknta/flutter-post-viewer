import 'package:equatable/equatable.dart';
import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:page_viewer/domain/use_cases/remote_use_cases/fetch_all_posts.dart';
import 'package:page_viewer/domain/use_cases/remote_use_cases/fetch_comments_by_post_id.dart';
import 'package:page_viewer/internal/locator.dart';
import 'package:page_viewer/internal/navigation/navigation.dart';
import 'package:page_viewer/presentation/utils/mixins/bloc_stream_mixin.dart';
import 'package:rxdart/rxdart.dart';

export 'package:page_viewer/presentation/utils/extensions/bloc_context_finder_extension.dart';
part 'post_viewer_event.dart';
part 'post_viewer_state.dart';

class PostViewerBloc with BlocStreamMixin {
  PostViewerBloc() {
    _eventController.listen(_handleEvent);
  }

  final _eventController = BehaviorSubject<PostViewerEvent>.seeded(const InitPostsEvent());
  Function(PostViewerEvent) get addEvent => sinkAdd(_eventController);

  final _postStateController = BehaviorSubject<PostViewerState>();
  Stream<PostViewerState> get postStateStream => _postStateController.stream;
  Function(PostViewerState) get _addPostState => sinkAdd(_postStateController);

  Future<void> _handleEvent(PostViewerEvent event) async {
    if (event is InitPostsEvent) {
      // TODO: make checking from DB
      await _fetchPostsAndUpdateState();
    } else if (event is TapOnLoadPostsButtonEvent || event is TapOnTryAgainButtonEvent) {
      await _fetchPostsAndUpdateState();
    } else if (event is TapOnPostFromListEvent) {
      await _fetchCommentsByPostIdAndRouteToPost(postEntity: event.postEntity);
    } else if (event is TapOnBackButtonFromPostPageEvent) {
      locator<NavigationService>().navigateTo(homeRoute);
    }
  }

  Future<void> _fetchPostsAndUpdateState() async {
    final List<PostEntity> postList = await FetchAllPosts(remoteRepository: locator<IRemoteRepository>()).execute();
    _addPostState(LoadedPostsState(posts: postList));
  }

  Future<void> _fetchCommentsByPostIdAndRouteToPost({required PostEntity postEntity}) async {
    final List<CommentEntity> commentList =
        await FetchCommentsByPostId(remoteRepository: locator<IRemoteRepository>()).execute(params: postEntity.id);
    locator<NavigationService>().navigateTo(
      postRoute,
      arguments: <String, dynamic>{
        postRoutePostEntityArgument: postEntity,
        postRouteCommentEntityListArgument: commentList,
      },
    );
  }

  @override
  void dispose() {
    if (isStreamNotClosed(_eventController)) {
      _eventController.close();
    }
    if (isStreamNotClosed(_postStateController)) {
      _postStateController.close();
    }
  }
}
