import 'package:flutter/foundation.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/download_task.dart';

abstract class ITaskObserver extends ChangeNotifier {
  Set<IDownloadTask> get tasks;
  void add(IDownloadTask task);
  void complete(int taskId);
}

class TaskObserver extends ITaskObserver {
  @override
  Set<IDownloadTask> tasks = {};

  @override
  void add(IDownloadTask task) {
    tasks.add(task);
  }

  @override
  void complete(int taskId) {
    tasks.removeWhere((task) => task.taskId == taskId);
    if (tasks.isEmpty) {
      notifyListeners();
    }
  }
}
