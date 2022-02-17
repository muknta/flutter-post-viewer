import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:page_viewer/domain/use_cases/i_use_case.dart';

class GetAllPosts implements IUseCase<List<PostEntity>, NoParams> {
  const GetAllPosts({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<List<PostEntity>> execute({NoParams? params}) => _localRepository.getAllPosts();
}
