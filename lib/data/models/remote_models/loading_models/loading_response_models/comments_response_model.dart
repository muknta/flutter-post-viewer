import 'package:page_viewer/data/models/remote_models/loading_models/loading_response_models/i_loading_response_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_status.dart';

class CommentsResponseModel extends ILoadingResponseModel {
  const CommentsResponseModel({
    required int taskId,
    required LoadingStatus status,
  }) : super(taskId: taskId, status: status);
}
