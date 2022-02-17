import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/data_sources/local_data_source/i_local_data_source.dart';
import 'package:page_viewer/data/models/local_models/comment_table_model.dart';
import 'package:page_viewer/data/models/local_models/post_table_model.dart';
import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/domain/repositories/local_repositories/i_local_repository.dart';

@LazySingleton(as: ILocalRepository)
class LocalRepository implements ILocalRepository {
  LocalRepository({
    required ILocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final ILocalDataSource _localDataSource;

  @override
  Future<List<bool>> insertPosts({required List<PostEntity> posts}) async {
    final List<PostTableModel> postTableModelList =
        posts.map((post) => PostTableModel.fromPostEntity(postEntity: post)).toList();
    return await _localDataSource.insertPosts(posts: postTableModelList);
  }

  @override
  Future<List<bool>> insertComments({required List<CommentEntity> comments}) async {
    print('before LocalRepo insertComm');
    final List<CommentTableModel> commentTableModelList =
        comments.map((comment) => CommentTableModel.fromCommentEntity(commentEntity: comment)).toList();
    print('after LocalRepo insertComm');
    return await _localDataSource.insertComments(comments: commentTableModelList);
  }

  @override
  Future<List<PostEntity>> getAllPosts() async {
    final List<PostTableModel> postTableModelList = await _localDataSource.getAllPosts();
    return postTableModelList
        .map((postTableModel) => PostEntity.fromPostTableModel(postTableModel: postTableModel))
        .toList();
  }

  @override
  Future<PostEntity?> getPostById({required int id}) async {
    final PostTableModel? postTableModel = await _localDataSource.getPostById(id: id);
    return postTableModel != null ? PostEntity.fromPostTableModel(postTableModel: postTableModel) : null;
  }

  @override
  Future<List<CommentEntity>> getCommentsByPostId({required int postId}) async {
    final List<CommentTableModel> commentTableModelList = await _localDataSource.getCommentsByPostId(postId: postId);
    return commentTableModelList
        .map((commentTableModel) => CommentEntity.fromCommentTableModel(commentTableModel: commentTableModel))
        .toList();
  }

  @override
  Future<bool> deleteAllPosts() => _localDataSource.deleteAllPosts();
}
