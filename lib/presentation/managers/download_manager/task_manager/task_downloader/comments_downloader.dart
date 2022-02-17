import 'package:page_viewer/data/models/remote_models/loading_models/loading_query_models/comments_query_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_status.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:page_viewer/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:page_viewer/internal/locator.dart';
import 'package:page_viewer/presentation/managers/download_manager/download_state.dart';
import 'package:page_viewer/presentation/managers/download_manager/single_task_downloader/comments_single_task_downloader.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/download_task.dart';
import 'package:page_viewer/presentation/managers/download_manager/task_manager/task_downloader/i_task_downloader.dart';
import 'package:page_viewer/presentation/utils/mixins/bloc_stream_mixin.dart';
import 'package:rxdart/subjects.dart';

class CommentsDownloader with BlocStreamMixin implements ITaskDownloader<CommentsDownloadTask> {
  CommentsDownloader({required this.sendErrorState})
      : localRepository = locator<ILocalRepository>(),
        remoteRepository = locator<IRemoteRepository>() {
    _commentsTaskController.stream.listen(_executeTask);
  }

  final ILocalRepository localRepository;
  final IRemoteRepository remoteRepository;
  @override
  final Function(IDownloadState) sendErrorState;

  final _commentsTaskController = PublishSubject<CommentsDownloadTask>();
  @override
  Function(CommentsDownloadTask) get sendTask => sinkAdd(_commentsTaskController);

  Future<void> _executeCommentsDownload(CommentsDownloadTask task) async {
    final commentsDownloader = CommentsSingleTaskDownloader(
      queryModel: CommentsQueryModel(
        postId: task.postId,
      ),
    );

    commentsDownloader.statusStream.listen((status) {
      if (loadingStatusIsError(status)) {
        sendErrorState(const DownloadErrorState());
        commentsDownloader.dispose();
      } else if (loadingStatusIsSuccess(status)) {
        task.onComplete(task.taskId);
        commentsDownloader.dispose();
      }
    });

    await commentsDownloader.startLoading();
  }

  Future<void> _executeTask(IDownloadTask task) async {
    if (task is CommentsDownloadTask) {
      _executeCommentsDownload(task).then(
        (_) => task.onComplete(task.taskId),
        onError: (_) {
          sendErrorState(const DownloadErrorState());
        },
      );
    }
  }

  @override
  void dispose() {
    if (!_commentsTaskController.isClosed) {
      _commentsTaskController.close();
    }
  }
}
