import 'package:get_it/get_it.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/dao/comment_sqflite_dao.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/dao/post_sqflite_dao.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/sqflite_database.dart';
import 'package:page_viewer/data/data_sources/local_data_source/i_local_data_source.dart';
import 'package:page_viewer/data/data_sources/local_data_source/local_data_source.dart';
import 'package:page_viewer/data/data_sources/remote_data_source/i_remote_data_source.dart';
import 'package:page_viewer/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:page_viewer/data/repositories/local_repositories/local_repository.dart';
import 'package:page_viewer/data/repositories/remote_repositories/remote_repository.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:page_viewer/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:sqflite/sqflite.dart';

void registerRemoteRepository({required GetIt di}) {
  di
    ..registerLazySingleton<IRemoteDataSource>(() => RemoteDataSource())
    ..registerLazySingleton<IRemoteRepository>(() => RemoteRepository(remoteDataSource: di<IRemoteDataSource>()));
}

void registerLocalRepository({required GetIt di}) {
  di
    ..registerLazySingleton<CommentSqfliteDao>(() => CommentSqfliteDao())
    ..registerLazySingleton<PostSqfliteDao>(() => PostSqfliteDao())
    ..registerLazySingleton<ILocalDataSource>(() => LocalDataSource(
          commentSqfliteDao: di<CommentSqfliteDao>(),
          postSqfliteDao: di<PostSqfliteDao>(),
        ))
    ..registerLazySingleton<ILocalRepository>(() => LocalRepository(localDataSource: di<ILocalDataSource>()));
}
