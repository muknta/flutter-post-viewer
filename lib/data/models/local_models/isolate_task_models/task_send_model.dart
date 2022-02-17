import 'dart:isolate';

import 'package:page_viewer/data/models/local_models/isolate_task_models/i_task_query_model.dart';

class TaskSendModel {
  const TaskSendModel({
    required this.taskId,
    required this.sendPort,
    required this.queryModel,
  });

  final int taskId;
  final SendPort sendPort;
  final ITaskQueryModel queryModel;
}
