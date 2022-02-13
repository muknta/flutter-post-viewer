import 'package:dio/dio.dart';
import 'package:page_viewer/data/models/remote_models/comment_model.dart';
import 'package:page_viewer/data/models/remote_models/post_model.dart';
import 'package:page_viewer/internal/config.dart';
import 'package:retrofit/retrofit.dart';

part 'routes.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(postsApiRoute)
  Future<List<PostModel>> getAllPosts();

  @GET('$postsApiRoute/{id}')
  Future<PostModel> getPostById({@Path('id') required int id});

  @GET('${baseApiRoute}comments/{post_id}')
  Future<List<CommentModel>> getCommentsByPostId({@Path('post_id') required int postId});
}
