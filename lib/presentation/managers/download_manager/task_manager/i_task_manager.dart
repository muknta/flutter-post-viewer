import 'package:page_viewer/presentation/managers/download_manager/task_manager/download_task.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/task_downloader/i_task_downloader.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/task_observer.dart';

abstract class ITaskManager {
  ITaskDownloader<CommentsDownloadTask> get commentsDownloader;

  ITaskObserver get observer;

  void doDownloadTasks() {
    for (final task in observer.tasks) {
      delegateTask(task);
    }
  }

  void delegateTask(IDownloadTask task) {
    if (task is CommentsDownloadTask) {
      commentsDownloader.sendTask(task);
    }
  }

  void createDownloadTasks({required List<int> postIdList}) {
    int taskId = 0;

    for (final int postId in postIdList) {
      observer.add(CommentsDownloadTask(
          taskId: ++taskId,
          postId: postId,
          onComplete: (id) {
            observer.complete(id);
          }));
      // TODO: For a test
      if (postId == 3) break;
    }
  }

  void clearTasks() {
    observer.tasks.clear();
  }

  void dispose() => throw UnimplementedError();
}
