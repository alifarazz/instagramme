import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:instagram_1/model/account.dart';
import 'package:instagram_1/model/comment.dart';
import 'package:instagram_1/model/following.dart';
import 'package:instagram_1/model/like.dart';
import 'package:instagram_1/model/post.dart';
import 'package:instagram_1/model/save.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    return _db = await initDB();
  }

  initDB() async {
    io.Directory docsDir = await getApplicationDocumentsDirectory();
    var path = join(docsDir.path, 'insta.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    final queries = [
      AccountModel.createQuery(),
      CommentModel.createQuery(),
      FollowingModel.createQuery(),
      LikeModel.createQuery(),
      PostModel.createQuery(),
      SaveModel.createQuery()
    ];
    for (var q in queries) await db.execute(q);
  }
}
