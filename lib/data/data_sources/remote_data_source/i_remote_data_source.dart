import 'package:page_viewer/data/models/remote_models/comment_model.dart';
import 'package:page_viewer/data/models/remote_models/post_model.dart';

abstract class IRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<PostModel?> getPostById({required int id});

  Future<List<CommentModel>> getCommentsByPostId({required int postId});
}
