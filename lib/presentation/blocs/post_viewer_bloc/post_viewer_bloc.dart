import 'package:equatable/equatable.dart';
import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:page_viewer/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:page_viewer/domain/use_cases/local_use_cases/delete_and_insert_posts.dart';
import 'package:page_viewer/domain/use_cases/local_use_cases/get_all_posts.dart';
import 'package:page_viewer/domain/use_cases/local_use_cases/get_comments_by_post_id.dart';
import 'package:page_viewer/domain/use_cases/local_use_cases/insert_comments.dart';
import 'package:page_viewer/domain/use_cases/remote_use_cases/fetch_all_posts.dart';
import 'package:page_viewer/domain/use_cases/remote_use_cases/fetch_comments_by_post_id.dart';
import 'package:page_viewer/internal/locator.dart';
import 'package:page_viewer/internal/navigation/navigation.dart';
import 'package:page_viewer/presentation/managers/download_manager/download_manager.dart';
import 'package:page_viewer/presentation/managers/download_manager/download_state.dart';
import 'package:page_viewer/presentation/utils/mixins/bloc_stream_mixin.dart';
import 'package:rxdart/rxdart.dart';

export 'package:page_viewer/presentation/utils/extensions/bloc_context_finder_extension.dart';
part 'post_viewer_event.dart';
part 'post_viewer_state.dart';

class PostViewerBloc with BlocStreamMixin {
  PostViewerBloc() {
    _eventController.listen(_handleEvent);

    /// For isolates
    // _downloadStateController.listen(_handleDownloadState);
  }

  final _eventController = BehaviorSubject<PostViewerEvent>.seeded(const InitPostsEvent());
  Function(PostViewerEvent) get addEvent => sinkAdd(_eventController);

  final _postStateController = BehaviorSubject<PostViewerState>();
  Stream<PostViewerState> get postStateStream => _postStateController.stream;
  Function(PostViewerState) get _addPostState => sinkAdd(_postStateController);

  final _downloadStateController = BehaviorSubject<IDownloadState>();
  Function(IDownloadState) get _addDownloadState => sinkAdd(_downloadStateController);

  FetchingCommentsStepAlertState? _fetchingCommentsAlert;

  Future<void> _handleEvent(PostViewerEvent event) async {
    if (event is InitPostsEvent) {
      await _getPostsAndUpdateState();
    } else if (event is TapOnLoadPostsButtonEvent || event is TapOnTryAgainButtonEvent) {
      await _getPostsAndUpdateState();
    } else if (event is TapOnPostFromListEvent) {
      await _getCommentsAndRouteToPostPage(postEntity: event.postEntity);
    } else if (event is TapOnBackButtonFromPostPageEvent) {
      locator<NavigationService>().navigateToPrevious();
    }
  }

  /// For isolates
  // Future<void> _handleDownloadState(IDownloadState state) async {
  //   if (state is DownloadDoneState && _fetchingCommentsAlert != null) {
  //     _fetchingCommentsAlert = _fetchingCommentsAlert!.copyWithIncrementedFetchedNumber();
  //     _addPostState(_fetchingCommentsAlert!);
  //     debugPrint('${_fetchingCommentsAlert!._fetchedNumber}/${_fetchingCommentsAlert!._overallNumber}');
  //   } else if (state is DownloadingState) {
  //     _addPostState(const FetchingPostsStepAlertState());
  //     debugPrint('DownloadingState');
  //   } else if (state is DownloadErrorState) {
  //     debugPrint('DownloadErrorState');
  //   }
  // }

  Future<void> _getPostsAndUpdateState() async {
    List<PostEntity> posts = await GetAllPosts(localRepository: locator<ILocalRepository>()).execute();
    if (posts.isEmpty) {
      posts = await _initDBInfo();
    }

    /// ---------- With Isolates
    //  else {
    //   _addPostState(LoadedPostsState(posts: posts));
    // }
    /// ---------- With Isolates

    /// ---------- Without Isolates
    _addPostState(LoadedPostsState(posts: posts));
    //
    /// ---------- Without Isolates
  }

  /// Generally DB feature is just a representation of knowledge and opportunities.
  /// For posts and comments DB is useless because we need always updated fetched data using internet.
  Future<List<PostEntity>> _initDBInfo() async {
    _addPostState(const FetchingPostsStepAlertState());
    final List<PostEntity> posts = await FetchAllPosts(remoteRepository: locator<IRemoteRepository>()).execute();
    _addPostState(const DeletingAndInsertingInfoStepAlertState());
    await DeleteAndInsertPosts(localRepository: locator<ILocalRepository>()).execute(params: posts);

    _fetchingCommentsAlert = FetchingCommentsStepAlertState(overallNumber: posts.length);
    _addPostState(_fetchingCommentsAlert!);
    final List<int> postIdList = posts.map((post) => post.id).toList();

    /// ---------- Without Isolates
    final comments = <CommentEntity>[];
    for (final int postId in postIdList) {
      comments
          .addAll(await FetchCommentsByPostId(remoteRepository: locator<IRemoteRepository>()).execute(params: postId));
      _fetchingCommentsAlert = _fetchingCommentsAlert!.copyWithIncrementedFetchedNumber();
      _addPostState(_fetchingCommentsAlert!);
    }
    _addPostState(const InsertingCommentsStepAlertState());
    await InsertComments(localRepository: locator<ILocalRepository>()).execute(params: comments);
    //
    /// ---------- Without Isolates

    /// ---------- With Isolates
    /// Isolate can not write comments into local SQL memory
    /// even if gave to him full DB path.
    ///
    /// And isolates crashes app with big number of comments, if we pushes all at the same time.
    // DownloadManager(sendState: _addDownloadState).download(postIdList: postIdList);
    /// ---------- With Isolates

    return posts;
  }

  Future<void> _getCommentsAndRouteToPostPage({required PostEntity postEntity}) async {
    final List<CommentEntity> commentList =
        await GetCommentsByPostId(localRepository: locator<ILocalRepository>()).execute(params: postEntity.id);
    await locator<NavigationService>().navigateTo(
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
    if (isStreamNotClosed(_downloadStateController)) {
      _downloadStateController.close();
    }
  }
}
