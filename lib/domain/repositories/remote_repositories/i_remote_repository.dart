import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';

abstract class IRemoteRepository {
  Future<List<PostEntity>> getAllPosts();

  Future<PostEntity?> getPostById({required int id});

  Future<List<CommentEntity>> getCommentsByPostId({required int postId});
}
