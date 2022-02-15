import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/schemas/comment_sqflite_schema.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton()
class CommentSqfliteDao {
  Future<Database> get _db async => await SqfliteDatabase.instance.database;

  Future<List<int>> insertAll({required List<Map<String, dynamic>> comments}) async {
    final listOfReturnedValues = <int>[];
    for (final Map<String, dynamic> comment in comments) {
      listOfReturnedValues.add(await insert(comment: comment));
    }
    return listOfReturnedValues;
  }

  Future<int> insert({required Map<String, dynamic> comment}) async => (await _db).insert(
        CommentSqfliteSchema.tableName,
        comment,
      );

  Future<int> deleteByPostId({required int postId}) async => (await _db).delete(
        CommentSqfliteSchema.tableName,
        where: '${CommentSqfliteSchema.postId} = ?',

        /// To prevent SQL injection
        whereArgs: [postId],
      );

  Future<int> deleteAll() async => (await _db).delete(CommentSqfliteSchema.tableName);

  Future<List<Map<String, dynamic>>> getCommentsByPostId({required int postId}) async => (await _db).query(
        CommentSqfliteSchema.tableName,
        where: '${CommentSqfliteSchema.postId} = ?',

        /// To prevent SQL injection
        whereArgs: [postId],
      );
}
