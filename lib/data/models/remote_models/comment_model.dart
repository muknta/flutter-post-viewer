import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  const CommentModel({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'postId')
  final int postId;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'body', defaultValue: '')
  final String body;
}
