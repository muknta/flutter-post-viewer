import 'package:equatable/equatable.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_status.dart';

abstract class ILoadingResponseModel extends Equatable {
  const ILoadingResponseModel({
    required this.taskId,
    required this.status,
  });

  final int taskId;
  final LoadingStatus status;

  @override
  List<Object?> get props => [taskId, status];
}
