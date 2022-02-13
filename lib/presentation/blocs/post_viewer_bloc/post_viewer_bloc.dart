import 'package:equatable/equatable.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';
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

  final _eventController = BehaviorSubject<PostViewerEvent>();
  Function(PostViewerEvent) get addEvent => sinkAdd(_eventController);

  final _postStateController = BehaviorSubject<PostViewerState>();
  Stream<PostViewerState> get postStateStream => _postStateController.stream;
  Function(PostViewerState) get _addPostState => sinkAdd(_postStateController);

  void _handleEvent(PostViewerEvent event) {
    if (event is TapOnLoadPostsButtonEvent) {
      // TODO: implement
    } else if (event is TapOnTryAgainButtonEvent) {
      // TODO: implement
    } else if (event is TapOnPostFromListEvent) {
      locator<NavigationService>().navigateTo(
        postRoute,
        arguments: <String, dynamic>{postRoutePostEntityArgument: event.postEntity},
      );
    } else if (event is TapOnBackButtonFromPostPageEvent) {
      locator<NavigationService>().navigateTo(homeRoute);
    }
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
