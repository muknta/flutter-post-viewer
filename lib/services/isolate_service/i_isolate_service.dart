import 'dart:isolate';
import 'package:page_viewer/data/models/local_models/isolate_task_models/i_task_query_model.dart';
import 'package:page_viewer/data/models/local_models/isolate_task_models/task_send_model.dart';

abstract class IIsolateService {
  Future<int> startIsolateTask({
    required void Function(TaskSendModel sendModel) staticFunction,
    required ITaskQueryModel queryModel,
    required SendPort sendPort,
    bool shouldNotifyTaskWorkFinished = false,
  });
  bool hasActiveTasks();
  List<int> getActiveTaskIds();

  void killTaskById(int id);
  void killAllTasks();
}
