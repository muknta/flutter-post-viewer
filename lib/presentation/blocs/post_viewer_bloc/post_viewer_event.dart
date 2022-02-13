part of 'post_viewer_bloc.dart';

abstract class PostViewerEvent {
  const PostViewerEvent();
}

class LoadPostsEvent extends PostViewerEvent {
  const LoadPostsEvent();
}

class OpenPostEvent extends PostViewerEvent {
  const OpenPostEvent();
}
