import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:page_viewer/domain/use_cases/i_use_case.dart';

class GetCommentsByPostId implements IUseCase<List<CommentEntity>, int> {
  const GetCommentsByPostId({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<List<CommentEntity>> execute({required int params}) => _localRepository.getCommentsByPostId(postId: params);
}
