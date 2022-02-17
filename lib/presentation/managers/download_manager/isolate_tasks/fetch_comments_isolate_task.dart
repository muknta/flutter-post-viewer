import 'package:get_it/get_it.dart';
import 'package:page_viewer/data/models/local_models/isolate_task_models/task_send_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_query_models/comments_query_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_response_models/comments_response_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_status.dart';
import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:page_viewer/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:page_viewer/domain/use_cases/local_use_cases/insert_comments.dart';
import 'package:page_viewer/domain/use_cases/remote_use_cases/fetch_comments_by_post_id.dart';
import 'package:page_viewer/internal/logger.dart';
import 'package:page_viewer/presentation/managers/download_manager/isolate_tasks/helpers/top_level_di_register.dart';

Future<void> fetchCommentsIsolateTask(TaskSendModel taskModel) async {
  if (taskModel.queryModel is! CommentsQueryModel) {
    return;
  }

  final query = taskModel.queryModel as CommentsQueryModel;

  try {
    final isolateGetIt = GetIt.instance;
    registerLocalRepository(di: isolateGetIt);
    registerRemoteRepository(di: isolateGetIt);

    taskModel.sendPort.send(
      CommentsResponseModel(
        status: LoadingStatus.loading,
        taskId: taskModel.taskId,
      ),
    );

    final List<CommentEntity> comments =
        await FetchCommentsByPostId(remoteRepository: isolateGetIt<IRemoteRepository>()).execute(params: query.postId);
    final bool isSuccessfulInserting =
        await InsertComments(localRepository: isolateGetIt<ILocalRepository>()).execute(params: comments);

    taskModel.sendPort.send(
      CommentsResponseModel(
        status: isSuccessfulInserting ? LoadingStatus.success : LoadingStatus.error,
        taskId: taskModel.taskId,
      ),
    );
  } on Exception catch (e, t) {
    logError('Error while comments loading in isolates', e, t);
    taskModel.sendPort.send(
      CommentsResponseModel(
        status: LoadingStatus.error,
        taskId: taskModel.taskId,
      ),
    );
  }
}
