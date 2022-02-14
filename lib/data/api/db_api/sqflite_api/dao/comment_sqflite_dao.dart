import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/api/db_api/sembast_api/schemas/comment_sembast_schema.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton()
class CommentSqfliteDao {
  Future<Database> get _db => SqfliteDatabase.instance.database;

  Future<List<int>> insertAll({required List<Map<String, dynamic>> comments}) async =>
      _commentsFolder.addAll(await _db, comments);

  Future<int> insert({required Map<String, dynamic> comment}) async => _commentsFolder.add(await _db, comment);

  Future<int> delete({required int levelId}) async {
    final Finder levelFinder = Finder(filter: Filter.equals(CommentSembastSchema.id, levelId));
    return _commentsFolder.delete(await _db, finder: levelFinder);
  }

  Future<List<Map<String, dynamic>>> getCommentsByPostId({required int postId}) async {
    final records = await _commentsFolder.find(await _db);
    return records.map((recordSnapshot) => recordSnapshot.value).toList();
  }
}
