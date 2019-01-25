import 'db/dbhelper.dart';
import 'account.dart';

class PostModel {
  AccountModel account;
  String pid;
  String photo;
  DateTime dateTime;
  String caption;

  static String createQuery() {
    return '''CREATE TABLE "POST"  ( 
  "pid"     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "uid"     INTEGER NOT NULL,
  "photo"   VARCHAR,
  "caption" TEXT,
  FOREIGN KEY("uid") REFERENCES "ACCOUNT"("uid") ON UPDATE CASCADE ON DELETE CASCADE
);''';
  }

  void insertDB() async {
    var dbClient = await DBHelper().db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert('''INSERT into POST (uid, date, photo, caption)
      VALUES(?, ?, ?, ?)''', [this.account.uid, this.dateTime, this.photo, this.caption]);
    });
  }

  PostModel(this.account, this.pid, this.photo, this.dateTime, this.caption);
}
