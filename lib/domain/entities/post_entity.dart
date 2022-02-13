import 'package:equatable/equatable.dart';
import 'package:page_viewer/data/models/remote_models/post_model.dart';

class PostEntity extends Equatable {
  const PostEntity._({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostEntity.fromPostModel({required PostModel postModel}) => PostEntity._(
        id: postModel.id,
        userId: postModel.userId,
        title: postModel.title,
        body: postModel.body,
      );

  final int id;
  final int userId;
  final String title;
  final String body;

  @override
  List<Object> get props => [id, userId, title, body];
}
