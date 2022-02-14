import 'dart:async';

import 'package:page_viewer/internal/config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDatabase {
  SembastDatabase._();

  static final _singleton = SembastDatabase._();

  static SembastDatabase get instance => _singleton;
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
    final database = await databaseFactoryIo.openDatabase(_fullDBPath!);
    return _dbOpenCompleter!.complete(database);
  }

  Future<void> _deleteDatabase() async {
    _fullDBPath ??= await _getDBPath();
    await databaseFactoryIo.deleteDatabase(_fullDBPath!);
  }

  Future<String> _getDBPath() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    _fullDBPath = join(appDocumentDir.path, sembastDBName);
    return _fullDBPath!;
  }
}
