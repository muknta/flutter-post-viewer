import 'dart:isolate';

import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/models/local_models/isolate_task_models/i_task_query_model.dart';
import 'package:page_viewer/data/models/local_models/isolate_task_models/task_response_models/task_unhandled_error_response_model.dart';
import 'package:page_viewer/data/models/local_models/isolate_task_models/task_response_models/task_work_done_response_model.dart';
import 'package:page_viewer/data/models/local_models/isolate_task_models/task_send_model.dart';
import 'package:page_viewer/services/isolate_service/i_isolate_service.dart';
import 'package:page_viewer/services/isolate_service/task_isolate_service_impl/executing_task.dart';

@LazySingleton(as: IIsolateService)
class IsolateService extends IIsolateService {
  final List<ExecutingTask> _activeTasks = [];
  int _lastTaskId = 0;

  @override
  bool hasActiveTasks() => _activeTasks.isNotEmpty;

  @override
  void killAllTasks() {
    for (final ExecutingTask task in _activeTasks) {
      _activeTasks.remove(task..killIsolate());
    }
  }

  @override
  void killTaskById(int id) {
    if (_activeTasks.isNotEmpty && _activeTasks.any((task) => task.id == id)) {
      _activeTasks.removeAt(_activeTasks.indexWhere((task) => task.id == id)).killIsolate();
    }
  }

  @override
  List<int> getActiveTaskIds() {
    if (_activeTasks.isEmpty) {
      return [];
    } else {
      return _activeTasks.map((task) => task.id).toList();
    }
  }

  @override
  Future<int> startIsolateTask({
    required void Function(TaskSendModel sendModel) staticFunction,
    required ITaskQueryModel queryModel,
    required SendPort sendPort,
    bool shouldNotifyTaskWorkFinished = true,
  }) async {
    final int taskId = _lastTaskId++;
    final ReceivePort taskExitReceivePort = ReceivePort();
    final ReceivePort errorReceiver = ReceivePort();
    final TaskSendModel taskSendModel = TaskSendModel(taskId: taskId, sendPort: sendPort, queryModel: queryModel);
    final Isolate isolate = await Isolate.spawn(staticFunction, taskSendModel,
        onExit: taskExitReceivePort.sendPort, onError: errorReceiver.sendPort);
    _activeTasks.add(
      ExecutingTask(
        id: taskId,
        isolate: isolate,
        taskExitReceivePort: taskExitReceivePort,
        errorReceivePort: errorReceiver,
        taskTerminated: (taskId, terminated, errorMessage) {
          SendPort? taskSendPort;
          if (shouldNotifyTaskWorkFinished) {
            taskSendPort = sendPort;
          }
          _deleteTaskFromWorkList(
              taskId: taskId, exitPort: taskSendPort, terminated: terminated, message: errorMessage);
        },
      ),
    );
    return taskId;
  }

  void _deleteTaskFromWorkList({
    required int taskId,
    required SendPort? exitPort,
    required TaskWorkFinished terminated,
    required String? message,
  }) {
    if (_activeTasks.any((task) => task.id == taskId)) {
      _activeTasks.removeAt(_activeTasks.indexWhere((task) => task.id == taskId));
      if (exitPort != null) {
        if (terminated == TaskWorkFinished.workDone) {
          exitPort.send(TaskWorkDoneResponseModel(taskId: taskId));
        } else {
          exitPort.send(TaskUnhandledErrorResponseModel(taskId: taskId, message: message!));
        }
      }
    }
  }
}
