part of 'post_viewer_bloc.dart';

abstract class PostViewerState extends Equatable {
  const PostViewerState();

  @override
  List<Object?> get props => [];
}

/// States that alert about loading steps
/// and indicate text on home page
abstract class LoadingStepAlertState extends PostViewerState {
  const LoadingStepAlertState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
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

class DeletingAndInsertingInfoStepAlertState extends LoadingStepAlertState {
  const DeletingAndInsertingInfoStepAlertState() : super(message: 'Inserting posts...');
}

class LoadedPostsState extends PostViewerState {
  const LoadedPostsState({required this.posts});

  final List<PostEntity> posts;

  @override
  List<Object?> get props => [posts];
}

class PostsNotFoundState extends PostViewerState {
  const PostsNotFoundState();
}

class ErrorWhileLoadingPostsState extends PostViewerState {
  const ErrorWhileLoadingPostsState();
}
