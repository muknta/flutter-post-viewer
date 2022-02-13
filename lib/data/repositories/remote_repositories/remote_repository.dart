import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/data_sources/remote_data_source/i_remote_data_source.dart';
import 'package:page_viewer/data/models/remote_models/comment_model.dart';
import 'package:page_viewer/data/models/remote_models/post_model.dart';
import 'package:page_viewer/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';

@LazySingleton(as: IRemoteRepository)
class RemoteRepository extends IRemoteRepository {
  RemoteRepository({
    required IRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final IRemoteDataSource _remoteDataSource;

  @override
  Future<List<PostEntity>> fetchAllPosts() async {
    final List<PostModel> postModelList = await _remoteDataSource.fetchAllPosts();
    final postEntityList = <PostEntity>[];
    for (final PostModel postModel in postModelList) {
      postEntityList.add(PostEntity.fromPostModel(postModel: postModel));
    }
    return postEntityList;
  }

  @override
  Future<PostEntity?> fetchPostById({required int id}) async {
    final PostModel? postModel = await _remoteDataSource.fetchPostById(id: id);
    if (postModel != null) {
      return PostEntity.fromPostModel(postModel: postModel);
    }
    return Future.value();
  }

  @override
  Future<List<CommentEntity>> fetchCommentsByPostId({required int postId}) async {
    final List<CommentModel> commentModelList = await _remoteDataSource.fetchCommentsByPostId(postId: postId);
    final commentEntityList = <CommentEntity>[];
    for (final CommentModel commentModel in commentModelList) {
      commentEntityList.add(CommentEntity.fromCommentModel(commentModel: commentModel));
    }
    return commentEntityList;
  }
}
