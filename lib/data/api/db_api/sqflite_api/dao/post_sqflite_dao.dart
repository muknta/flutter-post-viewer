import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/schemas/post_sqflite_schema.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton()
class PostSqfliteDao {
  Future<Database> get _db => SqfliteDatabase.instance.database;

  Future<List<int>> insertAll({required List<Map<String, dynamic>> posts}) async {
    final listOfReturnedValues = <int>[];
    for (final Map<String, dynamic> post in posts) {
      listOfReturnedValues.add(await insert(post: post));
    }
    return listOfReturnedValues;
  }

  Future<int> insert({required Map<String, dynamic> post}) async => (await _db).insert(
        PostSqfliteSchema.tableName,
        post,
      );

  Future<int> deleteById({required int id}) async => (await _db).delete(
        PostSqfliteSchema.tableName,
        where: '${PostSqfliteSchema.id} = ?',

        /// To prevent SQL injection
        whereArgs: [id],
      );

  Future<int> deleteAll() async => (await _db).delete(PostSqfliteSchema.tableName);

  Future<Map<String, dynamic>?> getPostById({required int id}) async {
    final List<Map<String, dynamic>?> queryList = await (await _db).query(
      PostSqfliteSchema.tableName,
      where: '${PostSqfliteSchema.id} = ?',

      /// To prevent SQL injection
      whereArgs: [id],
      limit: 1,
    );
    return queryList.first;
  }

  Future<List<Map<String, dynamic>>> getAllPosts() async => (await _db).query(
        PostSqfliteSchema.tableName,
      );
}
