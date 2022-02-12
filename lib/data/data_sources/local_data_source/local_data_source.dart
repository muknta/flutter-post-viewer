import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/data_sources/local_data_source/i_local_data_source.dart';

@LazySingleton(as: ILocalDataSource)
class LocalDataSource implements ILocalDataSource {}
