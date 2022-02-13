import 'package:equatable/equatable.dart';
import 'package:page_viewer/data/models/remote_models/comment_model.dart';

class CommentEntity extends Equatable {
  const CommentEntity._({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentEntity.fromCommentModel({required CommentModel commentModel}) => CommentEntity._(
        id: commentModel.id,
        postId: commentModel.postId,
        name: commentModel.name,
        email: commentModel.email,
        body: commentModel.body,
      );

  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;

  @override
  List<Object> get props => [id, postId, name, email, body];
}
