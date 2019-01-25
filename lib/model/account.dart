import 'db/dbhelper.dart';

class AccountModel {
  String uid;
  String username;
  String fullname;
  String h_pass;
  String bio;
  String avatar;

  static String createQuery() {
    return '''CREATE TABLE "ACCOUNT" (
		"uid"       INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
		"username"  VARCHAR NOT NULL,
		"h_pass"    VARCHAR NOT NULL,
		"fullname"  VARCHAR NOT NULL,
		"bio"       TEXT,
		"avatar"    VARCHAR
		#PRIMARY KEY("uid")
		);''';
  }

  void insertDB() async {
    var dbClient = await DBHelper().db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert('''INSERT into ACCOUNT (username, fullname, h_pass, bio, avatar)
      VALUES(?, ?, ?, ?, ?)''', [this.username,this.fullname, this.h_pass, this.bio, this.avatar]);
    });
  }

  AccountModel(this.uid, this.username, this.fullname, this.h_pass, this.bio, this.avatar);

}
