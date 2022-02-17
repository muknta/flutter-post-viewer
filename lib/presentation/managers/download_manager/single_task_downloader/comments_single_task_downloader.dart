import 'dart:async';
import 'dart:isolate';

import 'package:page_viewer/data/models/remote_models/loading_models/loading_query_models/comments_query_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_response_models/comments_response_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_status.dart';
import 'package:page_viewer/internal/locator.dart';
import 'package:page_viewer/presentation/managers/download_manager/i_isolate_manager.dart';
import 'package:page_viewer/presentation/managers/download_manager/single_task_downloader/i_single_task_downloader.dart';
import 'package:page_viewer/presentation/utils/mixins/bloc_stream_mixin.dart';
import 'package:rxdart/rxdart.dart';

class CommentsSingleTaskDownloader extends ISingleTaskDownloader<CommentsQueryModel> with BlocStreamMixin {
  CommentsSingleTaskDownloader({
    required this.queryModel,
  }) : isolateManager = locator<IIsolateManager>() {
    _subscriptionToPort = responsePort.listen(responseHandler);
  }

  late final StreamSubscription _subscriptionToPort;
  final _statusController = PublishSubject<LoadingStatus>();
  Function(LoadingStatus) get _setStatus => sinkAdd(_statusController);

  @override
  final CommentsQueryModel queryModel;
  @override
  Stream<LoadingStatus> get statusStream => _statusController;
  @override
  final IIsolateManager isolateManager;
  @override
  final ReceivePort responsePort = ReceivePort();

  @override

  /// Port listener gives 'dynamic' type of response
  Future<void> responseHandler(dynamic response) async {
    if (response is CommentsResponseModel) {
      if (loadingStatusIsError(response.status)) {
        isolateManager.killTaskById(response.taskId);
      }
      _setStatus(response.status);
    }
  }

  @override
  void dispose() {
    _subscriptionToPort.cancel();
    if (!_statusController.isClosed) {
      _statusController.close();
    }
  }
}
