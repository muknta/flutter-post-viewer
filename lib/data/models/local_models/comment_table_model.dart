import 'package:json_annotation/json_annotation.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/schemas/comment_sqflite_schema.dart';
import 'package:page_viewer/domain/entities/comment_entity.dart';

part 'comment_table_model.g.dart';

@JsonSerializable()
class CommentTableModel {
  const CommentTableModel({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentTableModel.fromCommentEntity({required CommentEntity commentEntity}) => CommentTableModel(
        id: commentEntity.id,
        postId: commentEntity.postId,
        name: commentEntity.name,
        email: commentEntity.email,
        body: commentEntity.body,
      );

  factory CommentTableModel.fromJson(Map<String, dynamic> json) => _$CommentTableModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentTableModelToJson(this);

  @JsonKey(name: CommentSqfliteSchema.id)
  final int id;
  @JsonKey(name: CommentSqfliteSchema.postId)
  final int postId;
  @JsonKey(name: CommentSqfliteSchema.name, defaultValue: '')
  final String name;
  @JsonKey(name: CommentSqfliteSchema.email, defaultValue: '')
  final String email;
  @JsonKey(name: CommentSqfliteSchema.body, defaultValue: '')
  final String body;
}
