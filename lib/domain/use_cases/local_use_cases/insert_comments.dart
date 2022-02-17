import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:page_viewer/domain/use_cases/i_use_case.dart';

class InsertComments implements IUseCase<bool, List<CommentEntity>> {
  const InsertComments({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<bool> execute({required List<CommentEntity> params}) async {
    print('before INSERTING');
    final List<bool> resultList = await _localRepository.insertComments(comments: params);
    print('after INSERTING');
    return resultList.every((expectedPositiveValue) => expectedPositiveValue);
  }
}
