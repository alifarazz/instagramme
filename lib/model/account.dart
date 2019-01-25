import 'db/dbhelper.dart';
import 'package:flutter/material.dart';

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
		);''';
  }

  void insertDB() async {
    var dbClient = await DBHelper().db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert('''INSERT into ACCOUNT (username, fullname, h_pass, bio, avatar)
      VALUES(?, ?, ?, ?, ?)''', [this.username, this.fullname, this.h_pass, this.bio, this.avatar]);
    });
  }

  static Future<AccountModel> getByUID(String uid) async {
    var dbClient = await DBHelper().db;
    List<Map> list = await dbClient.rawQuery('''
    SELECT uid, username,fullname, h_pass, bio, avatar 
    FROM ACCOUNT
    WHERE ACCOUNT.uid = ?;''', [uid]);
    if (list.isEmpty) {
      debugPrint("[MODEL] with uid: $uid, AccountModel ny uid is empty");
      return null;
    }
    debugPrint("$list");
    AccountModel am = AccountModel(list[0]['uid'].toString(), list[0]['username'], list[0]['fullname'],
        list[0]['h_pass'], list[0]['bio'], list[0]['avatar']);

    debugPrint("[MODEL] query on $uid, count follower: ${am.toString()}");
    return am;
  }

  AccountModel(this.uid, this.username, this.fullname, this.h_pass, this.bio, this.avatar);
}
