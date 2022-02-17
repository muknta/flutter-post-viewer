part of 'post_viewer_bloc.dart';

abstract class PostViewerState {
  const PostViewerState();
}

/// States that alert about loading steps
/// and indicate text on home page
///
/// This state are needed for UI, so here not extends Equatable
/// for purpose to throw specific state on the same state
/// TODO: check in working version with Equatable
abstract class LoadingStepAlertState extends PostViewerState {
  const LoadingStepAlertState({required this.message});

  final String message;
}

class FetchingPostsStepAlertState extends LoadingStepAlertState {
  const FetchingPostsStepAlertState() : super(message: 'Fetching posts...');
}

class FetchingCommentsStepAlertState extends LoadingStepAlertState {
  const FetchingCommentsStepAlertState({required int overallNumber, int fetchedNumber = 0})
      : _overallNumber = overallNumber,
        _fetchedNumber = fetchedNumber,
        super(message: 'Fetching comments - $fetchedNumber/$overallNumber');

  FetchingCommentsStepAlertState copyWithIncrementedFetchedNumber() => FetchingCommentsStepAlertState(
        overallNumber: _overallNumber,
        fetchedNumber: _fetchedNumber + 1,
      );

  final int _overallNumber;
  final int _fetchedNumber;
}

class InsertingCommentsStepAlertState extends LoadingStepAlertState {
  const InsertingCommentsStepAlertState() : super(message: 'Inserting comments...');
}

class DeletingAndInsertingInfoStepAlertState extends LoadingStepAlertState {
  const DeletingAndInsertingInfoStepAlertState() : super(message: 'Inserting posts...');
}

class LoadedPostsState extends Equatable implements PostViewerState {
  const LoadedPostsState({required this.posts});

  final List<PostEntity> posts;

  @override
  List<Object?> get props => [posts];
}

class PostsNotFoundState extends Equatable implements PostViewerState {
  const PostsNotFoundState();

  @override
  List<Object?> get props => [];
}

class ErrorWhileLoadingPostsState extends Equatable implements PostViewerState {
  const ErrorWhileLoadingPostsState();

  @override
  List<Object?> get props => [];
}
