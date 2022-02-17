import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/helpers/const.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/schemas/comment_sqflite_schema.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton()
class CommentSqfliteDao {
  Future<Database> get _db async => await SqfliteDatabase.instance.database;

  Future<List<bool>> insertAll({required List<Map<String, dynamic>> comments}) async {
    print('before DAO insertComm');
    final listOfReturnedValues = <bool>[];
    for (final Map<String, dynamic> comment in comments) {
      print('COMMENT  ---- $comment');
      listOfReturnedValues.add(await insert(comment: comment));
      print('COMMENT  after insert $listOfReturnedValues');
    }
    print('after DAO insertComm');
    return listOfReturnedValues;
  }

  Future<bool> insert({required Map<String, dynamic> comment}) async =>
      await (await _db).insert(
        CommentSqfliteSchema.tableName,
        comment,
      ) !=
      unsuccessfulReturnValueSqflite;

  Future<bool> deleteByPostId({required int postId}) async =>
      await (await _db).delete(
        CommentSqfliteSchema.tableName,
        where: '${CommentSqfliteSchema.postId} = ?',

        /// To prevent SQL injection
        whereArgs: [postId],
      ) !=
      unsuccessfulReturnValueSqflite;

  Future<bool> deleteAll() async =>
      await (await _db).delete(CommentSqfliteSchema.tableName) != unsuccessfulReturnValueSqflite;

  Future<List<Map<String, dynamic>>> getCommentsByPostId({required int postId}) async => (await _db).query(
        CommentSqfliteSchema.tableName,
        where: '${CommentSqfliteSchema.postId} = ?',

        /// To prevent SQL injection
        whereArgs: [postId],
      );
}
