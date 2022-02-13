part of 'post_viewer_bloc.dart';

abstract class PostViewerEvent extends Equatable {
  const PostViewerEvent();

  @override
  List<Object> get props => [];
}

class TapOnLoadPostsEvent extends PostViewerEvent {
  const TapOnLoadPostsEvent();

  @override
  List<Object> get props => ['TapOnLoadPostsEvent'];
}

class TapOnTryAgainEvent extends PostViewerEvent {
  const TapOnTryAgainEvent();

  @override
  List<Object> get props => ['TapOnTryAgainEvent'];
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
