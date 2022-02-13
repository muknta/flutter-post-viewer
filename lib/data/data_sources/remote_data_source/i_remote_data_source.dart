import 'package:page_viewer/data/models/remote_models/comment_model.dart';
import 'package:page_viewer/data/models/remote_models/post_model.dart';

abstract class IRemoteDataSource {
  Future<List<PostModel>> fetchAllPosts();

  Future<PostModel?> fetchPostById({required int id});

  Future<List<CommentModel>> fetchCommentsByPostId({required int postId});
}
