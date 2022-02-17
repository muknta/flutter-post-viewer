import 'package:equatable/equatable.dart';

abstract class IDownloadTask extends Equatable {
  int get taskId;
  Function(int) get onComplete;
}

class CommentsDownloadTask extends IDownloadTask {
  CommentsDownloadTask({
    required this.taskId,
    required this.onComplete,
    required this.postId,
  });

  @override
  final int taskId;
  @override
  final Function(int) onComplete;
  final int postId;

  @override
  List<Object?> get props => [taskId, onComplete, postId];
}
