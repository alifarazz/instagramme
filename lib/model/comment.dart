import 'account.dart';
import 'post.dart';
import 'db/dbhelper.dart';

class CommentModel {
AccountModel account;
PostModel post;
  String content;

  static String createQuery() {
    return '''CREATE TABLE "COMMENT"  (
    "pid"           INTEGER NOT NULL,
    "uid"           INTEGER NOT NULL,
    "content"       TEXT,
    PRIMARY KEY("pid", "uid"),
    FOREIGN KEY("uid") REFERENCES "ACCOUNT"("uid")
    ON UPDATE CASCADE ON DELETE CASCADE
    FOREIGN KEY("pid") REFERENCES "POST"("pid")
    ON UPDATE CASCADE ON DELETE CASCADE
);''';
  }


  void insertDB() async {
    var dbClient = await DBHelper().db;
    await dbClient.transaction((txn) async{
      return await txn.rawInsert('''INSERT into COMMENT (uid, pid, content)
      VALUES(?, ?, ?)''', [this.account.uid, this.post.pid, this.content]);
    });
  }

CommentModel(this.account, this.post, this.content);

}
