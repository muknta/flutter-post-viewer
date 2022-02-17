import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:page_viewer/domain/use_cases/i_use_case.dart';

class GetPostById implements IUseCase<PostEntity?, int> {
  const GetPostById({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<PostEntity?> execute({required int params}) => _localRepository.getPostById(id: params);
}
