import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/api/rest_api/interceptors/dio_error_interceptor.dart';
import 'package:page_viewer/data/api/rest_api/rest_client/rest_client.dart';
import 'package:page_viewer/data/data_sources/remote_data_source/i_remote_data_source.dart';
import 'package:page_viewer/data/models/remote_models/comment_model.dart';
import 'package:page_viewer/data/models/remote_models/post_model.dart';
import 'package:page_viewer/internal/logger.dart';

@LazySingleton(as: IRemoteDataSource)
class RemoteDataSource implements IRemoteDataSource {
  RemoteDataSource() {
    final dio = Dio();

    // TODO: check in debug mode
    dio.interceptors.add(DioErrorInterceptor());
    _restClient = RestClient(dio);
  }

  late RestClient _restClient;

  @override
  Future<List<PostModel>> fetchAllPosts() async {
    try {
      return _restClient.fetchAllPosts();
    } on DioError catch (error, stackTrace) {
      logError('fetchAllPosts', error, stackTrace);
    }
    return <PostModel>[];
  }

  @override
  Future<PostModel?> fetchPostById({required int id}) async {
    try {
      return _restClient.fetchPostById(id: id);
    } on DioError catch (error, stackTrace) {
      logError('fetchPostById', error, stackTrace);
    }
    return Future.value();
  }

  @override
  Future<List<CommentModel>> fetchCommentsByPostId({required int postId}) async {
    try {
      return _restClient.fetchCommentsByPostId(postId: postId);
    } on DioError catch (error, stackTrace) {
      logError('fetchCommentsByPostId', error, stackTrace);
    }
    return <CommentModel>[];
  }
}
