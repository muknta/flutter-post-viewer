import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/models/local_models/isolate_task_models/task_response_models/task_unhandled_error_response_model.dart';
import 'package:page_viewer/data/models/local_models/isolate_task_models/task_response_models/task_work_done_response_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_query_models/comments_query_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_query_models/i_loading_query_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_response_models/comments_response_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_response_models/i_loading_response_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_status.dart';
import 'package:page_viewer/internal/locator.dart';
import 'package:page_viewer/presentation/managers/download_manager/i_isolate_manager.dart';
import 'package:page_viewer/presentation/managers/download_manager/isolate_tasks/fetch_comments_isolate_task.dart';
import 'package:page_viewer/presentation/utils/mixins/bloc_stream_mixin.dart';
import 'package:page_viewer/services/isolate_service/i_isolate_service.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IIsolateManager)

/// Class generates isolates, gives them taskId and manages their state
class IsolateManager extends IIsolateManager with BlocStreamMixin {
  IsolateManager()
      : _isolateService = locator<IIsolateService>(),
        _receivePort = ReceivePort() {
    _receivePort.listen(_allTaskResponseHandler);
  }

  final IIsolateService _isolateService;
  final _taskLoadingController = PublishSubject<ILoadingResponseModel>();
  final ReceivePort _receivePort;
  final List<ILoadingResponseModel> _loadingTaskList = [];

  List<ILoadingResponseModel> _getLoadingTaskList() => _loadingTaskList;

  Function(ILoadingResponseModel) get _sendLoadingModel => sinkAdd(_taskLoadingController);

  @override
  Future<void> startLoading(
    ILoadingQueryModel model, {
    SendPort? customPort,
  }) async {
    late final ILoadingResponseModel loadingModel;

    if (model is CommentsQueryModel) {
      final int taskId = await _isolateService.startIsolateTask(
        staticFunction: fetchCommentsIsolateTask,
        queryModel: model,
        sendPort: customPort ?? _receivePort.sendPort,
      );

      loadingModel = CommentsResponseModel(
        status: LoadingStatus.prepare,
        taskId: taskId,
      );
    }

    _loadingTaskList.add(loadingModel);
    _sendLoadingModel(loadingModel);

    return Future.value();
  }

  @override
  Stream<ILoadingResponseModel> get taskListener => _taskLoadingController.stream;

  /// 'late' because parameters can not be accessed in an initializer
  late final _commentsResponse = _DefaultUpdateResponse<CommentsResponseModel>(
    loadingTask: _getLoadingTaskList,
    sendLoadingModel: _sendLoadingModel,
  );

  // ignore: avoid_annotating_with_dynamic
  void _allTaskResponseHandler(dynamic response) {
    if (response is TaskWorkDoneResponseModel) {
      debugPrint('Done - ${response.taskId}');
    } else if (response is TaskUnhandledErrorResponseModel) {
      debugPrint('Error - ${response.message}');
    } else if (response is CommentsResponseModel) {
      _commentsResponse.update(response);
    }
  }

  @disposeMethod
  @override
  void dispose() {
    _isolateService.killAllTasks();
    if (!_taskLoadingController.isClosed) {
      _taskLoadingController.close();
    }
  }

  @override
  List<ILoadingResponseModel> get taskList => _loadingTaskList;

  @override
  void killTaskById(int id) {
    _isolateService.killTaskById(id);
  }
}

class _DefaultUpdateResponse<R extends ILoadingResponseModel> {
  const _DefaultUpdateResponse({
    required this.loadingTask,
    required this.sendLoadingModel,
  });

  final List<ILoadingResponseModel> Function() loadingTask;
  final Function(ILoadingResponseModel) sendLoadingModel;

  void update(R response) {
    if (loadingTask().any(
      (task) => task.taskId == response.taskId,
    )) {
      final int taskIndex = loadingTask().indexWhere(
        (task) => task.taskId == response.taskId,
      );
      if (response.status == LoadingStatus.success) {
        loadingTask().removeAt(taskIndex);
      } else {
        loadingTask()[taskIndex] = response;
      }
      sendLoadingModel(response);
    }
  }
}
