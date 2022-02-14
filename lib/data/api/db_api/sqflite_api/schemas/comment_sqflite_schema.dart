class CommentSqfliteSchema {
  const CommentSqfliteSchema._();

  static const String tableName = 'comments';

  static const String id = 'id';
  static const String postId = 'post_id';
  static const String name = 'name';
  static const String email = 'email';
  static const String body = 'body';
}
