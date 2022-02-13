part of 'post_viewer_bloc.dart';

abstract class PostViewerEvent extends Equatable {
  const PostViewerEvent();

  @override
  List<Object> get props => [];
}

class LoadPostsEvent extends PostViewerEvent {
  const LoadPostsEvent();

  @override
  List<Object> get props => ['LoadPostsEvent'];
}

class OpenPostEvent extends PostViewerEvent {
  const OpenPostEvent();

  @override
  List<Object> get props => ['OpenPostEvent'];
}
