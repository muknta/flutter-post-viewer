import 'package:page_viewer/presentation/managers/download_manager/download_state.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/download_task.dart';

abstract class ITaskDownloader<T extends IDownloadTask> {
  Function(T) get sendTask;
  Function(IDownloadState) get sendErrorState;
  void dispose();
}
