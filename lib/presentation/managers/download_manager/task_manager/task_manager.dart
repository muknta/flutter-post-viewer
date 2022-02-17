import 'package:page_viewer/presentation/managers/download_manager/download_state.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/download_task.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/i_task_manager.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/task_downloader/comments_downloader.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/task_downloader/i_task_downloader.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/task_observer.dart';

class TaskManager extends ITaskManager {
  TaskManager({
    required this.callbackToSendError,
  }) : commentsDownloader = CommentsDownloader(sendErrorState: callbackToSendError);

  final Function(IDownloadState) callbackToSendError;

  @override
  final ITaskDownloader<CommentsDownloadTask> commentsDownloader;

  @override
  final ITaskObserver observer = TaskObserver();

  @override
  void dispose() {
    commentsDownloader.dispose();
  }
}
