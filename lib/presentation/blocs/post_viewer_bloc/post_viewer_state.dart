part of 'post_viewer_bloc.dart';

abstract class PostViewerState extends Equatable {
  const PostViewerState();

  @override
  List<Object> get props => [];
}

/// States that alert about loading steps
/// and indicate text on home page
abstract class LoadingStepAlertState extends PostViewerState {
  const LoadingStepAlertState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class FetchingPostsStepAlertState extends LoadingStepAlertState {
  const FetchingPostsStepAlertState() : super(message: 'Fetching posts...');
}

class FetchingCommentsStepAlertState extends LoadingStepAlertState {
  const FetchingCommentsStepAlertState() : super(message: 'Fetching comments...');
}

class DeletingAndInsertingInfoStepAlertState extends LoadingStepAlertState {
  const DeletingAndInsertingInfoStepAlertState() : super(message: 'Inserting posts with comments...');
}

class LoadedPostsState extends PostViewerState {
  const LoadedPostsState({required this.posts});

  final List<PostEntity> posts;

  @override
  // TODO: check with 'this'
  List<Object> get props => ['LoadedPostsState', posts];
}

class PostsNotFoundState extends PostViewerState {
  const PostsNotFoundState();

  @override
  List<Object> get props => ['PostsNotFoundState'];
}

class ErrorWhileLoadingPostsState extends PostViewerState {
  const ErrorWhileLoadingPostsState();

  @override
  List<Object> get props => ['ErrorWhileLoadingPostsState'];
}
