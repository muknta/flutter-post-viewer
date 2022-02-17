import 'dart:async';

import 'package:page_viewer/presentation/managers/download_manager/download_state.dart';
import 'package:page_viewer/presentation/managers/download_manager/i_download_manager.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/i_task_manager.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/task_manager.dart';

class DownloadManager implements IDownloadManager {
  DownloadManager({
    required this.sendState,
  }) : taskManager = TaskManager(
          callbackToSendError: sendState,
        );

  late IDownloadState currentState;
  final ITaskManager taskManager;

  @override
  final Function(IDownloadState) sendState;

  void _sendAndSaveState(IDownloadState state) {
    currentState = state;
    sendState(state);
  }

  @override
  void download({required List<int> postIdList}) {
    taskManager.createDownloadTasks(postIdList: postIdList);
    if (taskManager.observer.tasks.isEmpty) {
      print('isEmpty list observer');
      _sendAndSaveState(const DownloadDoneState());
      return;
    }
    _sendAndSaveState(const DownloadingState());
    taskManager.observer.addListener(downloadIsCompletedListener);
    taskManager.doDownloadTasks();
  }

  void downloadIsCompletedListener() {
    _sendAndSaveState(const DownloadDoneState());
  }

  @override
  void dispose() {
    taskManager.dispose();
  }
}
