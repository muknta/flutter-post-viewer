import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';

abstract class ILocalRepository {
  Future<List<bool>> insertPosts({required List<PostEntity> posts});

  Future<List<bool>> insertComments({required List<CommentEntity> comments});

  Future<List<PostEntity>> getAllPosts();

  Future<PostEntity?> getPostById({required int id});

  Future<List<CommentEntity>> getCommentsByPostId({required int postId});

  Future<bool> deleteAllPosts();
}
