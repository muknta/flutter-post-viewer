import 'dart:isolate';

class ExecutingTask {
  ExecutingTask({
    required this.id,
    required Isolate isolate,
    required ReceivePort taskExitReceivePort,
    required ReceivePort errorReceivePort,
    required void Function(int taskId, TaskWorkFinished terminate, String? errorMessage) taskTerminated,
  })  : _isolate = isolate,
        _taskExitReceivePort = taskExitReceivePort,
        _taskTerminated = taskTerminated,
        _errorRReceivePort = errorReceivePort {
    _taskExitReceivePort.listen(_handleIsolateExitEvent);
    _errorRReceivePort.listen(_handleIsolateErrorEvent);
  }

  final int id;
  final Isolate _isolate;
  final ReceivePort _taskExitReceivePort;
  final ReceivePort _errorRReceivePort;
  final void Function(int taskId, TaskWorkFinished terminate, String? errorMessage) _taskTerminated;
  bool _isIsolateTerminated = false;

  void killIsolate() {
    _isolate.kill();
  }

  void _handleIsolateExitEvent(_) {
    if (_isIsolateTerminated) {
      _isIsolateTerminated = true;
      _isolate.kill();
      _taskTerminated(id, TaskWorkFinished.workDone, null);
    }
  }

  void _handleIsolateErrorEvent(error) {
    if (!_isIsolateTerminated) {
      _isIsolateTerminated = true;
      _isolate.kill();
      _taskTerminated(id, TaskWorkFinished.caughtUnhandledError, error.toString());
    }
  }
}

enum TaskWorkFinished {
  workDone,
  caughtUnhandledError,
}
