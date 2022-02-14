import 'package:injectable/injectable.dart';
import 'package:page_viewer/data/api/db_api/sembast_api/schemas/post_sembast_schema.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton()
class PostSqfliteDao {
  Future<Database> get _db => SqfliteDatabase.instance.database;

  Future<List<int>> insertAll({required List<Map<String, dynamic>> posts}) async =>
      _postsFolder.addAll(await _db, posts);

  Future<int> insert({required Map<String, dynamic> post}) async => _postsFolder.add(await _db, post);

  Future<int> delete({required int levelId}) async {
    final Finder levelFinder = Finder(filter: Filter.equals(PostSembastSchema.id, levelId));
    return _postsFolder.delete(await _db, finder: levelFinder);
  }

  Future<List<Map<String, dynamic>>> getAllPosts() async {
    final records = await _postsFolder.find(await _db);
    return records.map((recordSnapshot) => recordSnapshot.value).toList();
  }

  Future<Map<String, dynamic>> getPostById({required int id}) async {
    final records = await _postsFolder.find(await _db);
    return records.map((recordSnapshot) => recordSnapshot.value).toList();
  }
}
