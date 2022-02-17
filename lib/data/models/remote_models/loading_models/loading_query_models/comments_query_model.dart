import 'package:page_viewer/data/models/remote_models/loading_models/loading_query_models/i_loading_query_model.dart';

class CommentsQueryModel extends ILoadingQueryModel {
  const CommentsQueryModel({required this.postId});

  final int postId;
}
