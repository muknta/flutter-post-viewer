import 'package:json_annotation/json_annotation.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/schemas/post_sqflite_schema.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';

part 'post_table_model.g.dart';

@JsonSerializable()
class PostTableModel {
  const PostTableModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostTableModel.fromPostEntity({required PostEntity postEntity}) => PostTableModel(
        id: postEntity.id,
        userId: postEntity.userId,
        title: postEntity.title,
        body: postEntity.body,
      );

  factory PostTableModel.fromJson(Map<String, dynamic> json) => _$PostTableModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostTableModelToJson(this);

  @JsonKey(name: PostSqfliteSchema.id)
  final int id;
  @JsonKey(name: PostSqfliteSchema.userId)
  final int userId;
  @JsonKey(name: PostSqfliteSchema.title, defaultValue: '')
  final String title;
  @JsonKey(name: PostSqfliteSchema.body, defaultValue: '')
  final String body;
}
