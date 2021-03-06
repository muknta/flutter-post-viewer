import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/dao/comment_sqflite_dao.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/dao/post_sqflite_dao.dart';
import 'package:page_viewer/data/data_sources/local_data_source/i_local_data_source.dart';
import 'package:page_viewer/data/models/local_models/comment_table_model.dart';
import 'package:page_viewer/data/models/local_models/post_table_model.dart';
import 'package:path_provider/path_provider.dart';

@LazySingleton(as: ILocalDataSource)
class LocalDataSource implements ILocalDataSource {
  const LocalDataSource({
    required PostSqfliteDao postSqfliteDao,
    required CommentSqfliteDao commentSqfliteDao,
  })  : _postSqfliteDao = postSqfliteDao,
        _commentSqfliteDao = commentSqfliteDao;

  final PostSqfliteDao _postSqfliteDao;
  final CommentSqfliteDao _commentSqfliteDao;

  @override
  Future<List<bool>> insertPosts({required List<PostTableModel> posts}) => _postSqfliteDao.insertAll(
        posts: posts.map((post) => post.toJson()).toList(),
      );

  @override
  Future<List<bool>> insertComments({required List<CommentTableModel> comments}) async {
    return _commentSqfliteDao.insertAll(
      comments: comments.map((comment) => comment.toJson()).toList(),
    );
  }

  @override
  Future<List<PostTableModel>> getAllPosts() async {
    final postsInJson = await _postSqfliteDao.getAllPosts();
    return postsInJson.map((onePostInJson) => PostTableModel.fromJson(onePostInJson)).toList();
  }

  @override
  Future<PostTableModel?> getPostById({required int id}) async {
    final Map<String, dynamic>? postInJson = await _postSqfliteDao.getPostById(id: id);
    return postInJson != null ? PostTableModel.fromJson(postInJson) : null;
  }

  @override
  Future<List<CommentTableModel>> getCommentsByPostId({required int postId}) async {
    final commentsInJson = await _commentSqfliteDao.getCommentsByPostId(postId: postId);
    return commentsInJson.map((oneCommentInJson) => CommentTableModel.fromJson(oneCommentInJson)).toList();
  }

  @override
  Future<bool> deleteAllPosts() => _postSqfliteDao.deleteAll();
}
