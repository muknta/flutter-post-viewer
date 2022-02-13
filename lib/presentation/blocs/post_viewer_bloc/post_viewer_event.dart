part of 'post_viewer_bloc.dart';

abstract class PostViewerEvent extends Equatable {
  const PostViewerEvent();

  @override
  List<Object> get props => [];
}

class InitPostsEvent extends PostViewerEvent {
  const InitPostsEvent();

  @override
  List<Object> get props => ['InitPostsEvent'];
}

class TapOnLoadPostsButtonEvent extends PostViewerEvent {
  const TapOnLoadPostsButtonEvent();

  @override
  List<Object> get props => ['TapOnLoadPostsButtonEvent'];
}

class TapOnTryAgainButtonEvent extends PostViewerEvent {
  const TapOnTryAgainButtonEvent();

  @override
  List<Object> get props => ['TapOnTryAgainButtonEvent'];
}

class TapOnPostFromListEvent extends PostViewerEvent {
  const TapOnPostFromListEvent({required this.postEntity});

  final PostEntity postEntity;

  @override
  List<Object> get props => ['TapOnPostFromListEvent', postEntity];
}

class TapOnBackButtonFromPostPageEvent extends PostViewerEvent {
  const TapOnBackButtonFromPostPageEvent();

  @override
  List<Object> get props => ['TapOnBackButtonFromPostPageEvent'];
}
