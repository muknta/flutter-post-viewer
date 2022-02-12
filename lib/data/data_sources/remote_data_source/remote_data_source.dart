import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/data_sources/remote_data_source/i_remote_data_source.dart';

@LazySingleton(as: IRemoteDataSource)
class RemoteDataSource implements IRemoteDataSource {}
