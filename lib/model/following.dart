import 'account.dart';
import 'db/dbhelper.dart';

class FollowingModel {
  AccountModel follower;
  AccountModel followee;

  static String createQuery() {
    return '''CREATE TABLE "FOLLOWING"  ( 
    "follower"  INTEGER NOT NULL,
    "followee"  INTEGER NOT NULL,
    PRIMARY KEY("follower","followee"),
    FOREIGN KEY("follower") REFERENCES "ACCOUNT"("uid")
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY("followee") REFERENCES "ACCOUNT"("uid")
    ON UPDATE CASCADE ON DELETE CASCADE
);''';
  }

  void insertDB() async {
    var dbClient = await DBHelper().db;
    await dbClient.transaction((txn) async{
      return await txn.rawInsert('''INSERT into FOLLOWING (follower, followee)
      VALUES(?, ?)''', [this.follower.uid, this.followee.uid]);
    });
  }

  FollowingModel(this.followee, this.follower);
}
