import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';

abstract class IRemoteRepository {
  Future<List<PostEntity>> fetchAllPosts();

  Future<PostEntity?> fetchPostById({required int id});

  Future<List<CommentEntity>> fetchCommentsByPostId({required int postId});
}
