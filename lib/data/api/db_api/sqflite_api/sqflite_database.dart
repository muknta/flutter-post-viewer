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
  Completer<Database>? _dbOpenCompleter;
  String? _fullDBPath;

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      await _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  Future<void> _openDatabase() async {
    _fullDBPath ??= await _getDBPath();
    final database = await openDatabase(
      _fullDBPath!,
      onCreate: (db, version) => db.execute(
        '''
        CREATE TABLE ${PostSqfliteSchema.tableName}(
          ${PostSqfliteSchema.id} INTEGER PRIMARY KEY,
          ${PostSqfliteSchema.userId} INTEGER,
          ${PostSqfliteSchema.title} TEXT,
          ${PostSqfliteSchema.body} TEXT
        );
        CREATE TABLE ${CommentSqfliteSchema.tableName}(
          ${CommentSqfliteSchema.id} INTEGER PRIMARY KEY,
          ${CommentSqfliteSchema.postId} INTEGER,
          ${CommentSqfliteSchema.name} VARCHAR(255),
          ${CommentSqfliteSchema.email} VARCHAR(255),
          ${CommentSqfliteSchema.body} TEXT,
          FOREIGN KEY(${CommentSqfliteSchema.postId}) REFERENCES posts(${PostSqfliteSchema.id})
        );
        ''',
      ),
      version: 1,
    );
    return _dbOpenCompleter!.complete(database);
  }

  Future<void> _deleteDatabase() async {
    _fullDBPath ??= await _getDBPath();
    await deleteDatabase(_fullDBPath!);
  }

  Future<String> _getDBPath() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    _fullDBPath = join(appDocumentDir.path, sqfliteDBName);
    return _fullDBPath!;
  }
}
