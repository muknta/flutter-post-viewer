import 'package:page_viewer/data/models/local_models/comment_table_model.dart';
import 'package:page_viewer/data/models/local_models/post_table_model.dart';

abstract class ILocalDataSource {
  Future<List<bool>> insertPosts({required List<PostTableModel> posts});

  Future<List<bool>> insertComments({required List<CommentTableModel> comments});

  Future<List<PostTableModel>> getAllPosts();

  Future<PostTableModel?> getPostById({required int id});

  Future<List<CommentTableModel>> getCommentsByPostId({required int postId});

  Future<bool> deleteAllPosts();

  // Future<bool> deleteAllComments();
}
