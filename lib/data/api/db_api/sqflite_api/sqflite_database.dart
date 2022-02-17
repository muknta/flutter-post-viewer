import 'dart:async';

import 'package:page_viewer/data/api/db_api/sqflite_api/schemas/comment_sqflite_schema.dart';
import 'package:page_viewer/data/api/db_api/sqflite_api/schemas/post_sqflite_schema.dart';
import 'package:page_viewer/internal/config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase {
  SqfliteDatabase._();

  static final _singleton = SqfliteDatabase._();

  static SqfliteDatabase get instance => _singleton;
  String? _fullDBPath;

  Database? _database;
  Future<Database> get database async => _database ??= await _openDatabase();

  Future<Database> _openDatabase() async => await openDatabase(
        _fullDBPath ??= await _getDBPath(),
        onCreate: (db, version) async {
          await db.execute(_sqlCodeCreateTablePosts);
          await db.execute(_sqlCodeCreateTableComments);
        },
        version: 1,
      );

  final String _sqlCodeCreateTablePosts = '''
        CREATE TABLE ${PostSqfliteSchema.tableName}(
          ${PostSqfliteSchema.id} INTEGER PRIMARY KEY,
          ${PostSqfliteSchema.userId} INTEGER,
          ${PostSqfliteSchema.title} TEXT,
          ${PostSqfliteSchema.body} TEXT
        );
        ''';

  final String _sqlCodeCreateTableComments = '''
        CREATE TABLE ${CommentSqfliteSchema.tableName}(
          ${CommentSqfliteSchema.id} INTEGER PRIMARY KEY,
          ${CommentSqfliteSchema.postId} INTEGER,
          ${CommentSqfliteSchema.name} VARCHAR(255),
          ${CommentSqfliteSchema.email} VARCHAR(255),
          ${CommentSqfliteSchema.body} TEXT,
          FOREIGN KEY(${CommentSqfliteSchema.postId}) REFERENCES posts(${PostSqfliteSchema.id})
        );
        ''';

  Future<void> _deleteDatabase() async {
    await deleteDatabase(_fullDBPath ??= await _getDBPath());
  }

  Future<String> _getDBPath() async {
    // final appDocumentDir = await getApplicationDocumentsDirectory();
    _fullDBPath =
        '/data/user/0/com.example.page_viewer/app_flutter/sqflite.db'; //join(appDocumentDir.path, sqfliteDBName);
    return _fullDBPath!;
  }
}
