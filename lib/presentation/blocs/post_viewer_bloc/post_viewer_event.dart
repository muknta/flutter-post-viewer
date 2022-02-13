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

class TapOnPostFromListEvent extends PostViewerEvent {
  const TapOnPostFromListEvent({required this.postId});

  final int postId;

  @override
  List<Object> get props => ['TapOnPostFromListEvent', postId];
}

class TapOnBackButtonFromPostPageEvent extends PostViewerEvent {
  const TapOnBackButtonFromPostPageEvent();

  @override
  List<Object> get props => ['TapOnBackButtonFromPostPageEvent'];
}
