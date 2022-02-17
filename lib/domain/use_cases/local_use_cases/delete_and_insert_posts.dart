import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:page_viewer/domain/use_cases/i_use_case.dart';

/// Comments will be deleted together with posts
/// because comments have Foreign Key from the posts.
class DeleteAndInsertPosts implements IUseCase<bool, List<PostEntity>> {
  const DeleteAndInsertPosts({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<bool> execute({required List<PostEntity> params}) async {
    final returnValueList = <bool>[
      await _localRepository.deleteAllPosts(),
      ...await _localRepository.insertPosts(posts: params),
    ];
    return returnValueList.every((expectedPositiveValue) => expectedPositiveValue);
  }
}
