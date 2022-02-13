import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  const PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'userId')
  final int userId;
  @JsonKey(name: 'title', defaultValue: '')
  final String title;
  @JsonKey(name: 'body', defaultValue: '')
  final String body;
}
