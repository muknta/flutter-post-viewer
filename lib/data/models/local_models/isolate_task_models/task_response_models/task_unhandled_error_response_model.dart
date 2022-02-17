import 'package:page_viewer/data/models/local_models/isolate_task_models/task_response_models/i_task_response_model.dart';

class TaskUnhandledErrorResponseModel extends ITaskResponseModel {
  const TaskUnhandledErrorResponseModel({
    required int taskId,
    required this.message,
  }) : super(taskId: taskId);

  final String message;
}
