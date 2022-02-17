import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:page_viewer/domain/use_cases/i_use_case.dart';

class DeleteAndInsertPostsWithComments implements IUseCase<bool, PostsWithCommentsParams> {
  const DeleteAndInsertPostsWithComments({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<bool> execute({required PostsWithCommentsParams params}) async {
    final returnValueList = <bool>[
      await _localRepository.deleteAllPosts(),
      ...await _localRepository.insertPosts(posts: params.posts),
      ...await _localRepository.insertComments(comments: params.comments),
    ];
    return returnValueList.any((expectedPositiveValue) => !expectedPositiveValue);
  }
}

class PostsWithCommentsParams {
  const PostsWithCommentsParams({
    required this.posts,
    required this.comments,
  });

  final List<PostEntity> posts;
  final List<CommentEntity> comments;
}
