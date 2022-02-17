part of 'post_viewer_bloc.dart';

abstract class PostViewerEvent extends Equatable {
  const PostViewerEvent();

  @override
  List<Object?> get props => [];
}

class InitPostsEvent extends PostViewerEvent {
  const InitPostsEvent();
}

class TapOnLoadPostsButtonEvent extends PostViewerEvent {
  const TapOnLoadPostsButtonEvent();
}

class TapOnTryAgainButtonEvent extends PostViewerEvent {
  const TapOnTryAgainButtonEvent();
}

class TapOnPostFromListEvent extends PostViewerEvent {
  const TapOnPostFromListEvent({required this.postEntity});

  final PostEntity postEntity;

  @override
  List<Object?> get props => [postEntity];
}

class TapOnBackButtonFromPostPageEvent extends PostViewerEvent {
  const TapOnBackButtonFromPostPageEvent();
}
