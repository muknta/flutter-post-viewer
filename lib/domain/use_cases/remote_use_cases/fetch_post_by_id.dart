import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:page_viewer/domain/use_cases/i_use_case.dart';

class FetchPostById implements IUseCase<PostEntity?, int> {
  const FetchPostById({
    required IRemoteRepository remoteRepository,
  }) : _remoteRepository = remoteRepository;

  final IRemoteRepository _remoteRepository;

  @override
  Future<PostEntity?> execute({required int params}) => _remoteRepository.fetchPostById(
        id: params,
      );
}
