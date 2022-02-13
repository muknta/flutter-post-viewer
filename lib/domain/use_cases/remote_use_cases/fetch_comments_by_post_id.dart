import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:page_viewer/domain/use_cases/i_use_case.dart';

class FetchCommentsByPostId implements IUseCase<List<CommentEntity>, int> {
  const FetchCommentsByPostId({
    required IRemoteRepository remoteRepository,
  }) : _remoteRepository = remoteRepository;

  final IRemoteRepository _remoteRepository;

  @override
  Future<List<CommentEntity>> execute({required int params}) => _remoteRepository.fetchCommentsByPostId(
        postId: params,
      );
}
