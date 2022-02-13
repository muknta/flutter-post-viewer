part of 'post_viewer_bloc.dart';

abstract class PostViewerState extends Equatable {
  const PostViewerState();

  @override
  List<Object> get props => [];
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
