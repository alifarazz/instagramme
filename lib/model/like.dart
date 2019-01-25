import 'db/dbhelper.dart';
import 'account.dart';
import 'post.dart';

class LikeModel {
  AccountModel account;
  PostModel post;

  static String createQuery() {
    return '''CREATE TABLE "LIKE"  ( 
  "uid"     INTEGER NOT NULL,
  "pid"     INTEGER NOT NULL,
  PRIMARY KEY("uid","pid"),
  FOREIGN KEY("uid") REFERENCES "ACCOUNT"("uid")
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY("pid") REFERENCES "POST"(pid)
  ON UPDATE CASCADE ON DELETE CASCADE
);
''';
  }

  void insertDB() async {
    var dbClient = await DBHelper().db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert('''INSERT into LIKE(uid, pid)
      VALUES(?, ?)''', [this.account.uid, this.post.pid]);
    });
  }

  LikeModel(this.account, this.post);

}
