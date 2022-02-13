import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:page_viewer/domain/use_cases/i_use_case.dart';

class FetchAllPosts implements IUseCase<List<PostEntity>, NoParams> {
  const FetchAllPosts({
    required IRemoteRepository remoteRepository,
  }) : _remoteRepository = remoteRepository;

  final IRemoteRepository _remoteRepository;

  @override
  Future<List<PostEntity>> execute({NoParams? params}) => _remoteRepository.fetchAllPosts();
}
