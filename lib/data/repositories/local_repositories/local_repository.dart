import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/data_sources/local_data_source/i_local_data_source.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';

@LazySingleton(as: ILocalRepository)
class LocalRepository implements ILocalRepository {
  LocalRepository({
    required ILocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final ILocalDataSource _localDataSource;
}
