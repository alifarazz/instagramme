import 'db/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';

enum UpdateStatus { UsernameNotUnique, UpdateSuccessful }

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
    debugPrint("[MODEL] insert into account ${this.uid}");
  }

  static Future<String> isUsernameUnique(String username) async {
    var dbClient = await DBHelper().db;
    List<Map> list = await dbClient.transaction((txn) async {
      return await txn.rawQuery('''
			SELECT uid
			FROM ACCOUNT
			WHERE username = "$username"
			''');
    });
    if (list.isEmpty)
      return "";
    return list[0]["uid"].toString();
  }

  Future<UpdateStatus> update() async {
    var dbClient = await DBHelper().db;
    var uidWithSameUsername = await isUsernameUnique(this.username);
//    debugPrint("${this.uid}");
//    debugPrint("${uidWithSameUsername}");
    if (!(uidWithSameUsername == ''  || this.uid == uidWithSameUsername)) return UpdateStatus.UsernameNotUnique;
    await dbClient.rawUpdate('''
      UPDATE ACCOUNT
      SET username="${this.username}", h_pass="${this.h_pass}", fullname="${this.fullname}", bio = "${this.bio}"
      WHERE uid = "${this.uid}";''');
    debugPrint('''
      UPDATE ACCOUNT
      SET username="${this.username}", h_pass="${this.h_pass}", fullname="${this.fullname}", bio = "${this.bio}"
      WHERE uid = "${this.uid}"''');
    return UpdateStatus.UpdateSuccessful;
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
    AccountModel am = AccountModel(list[0]['uid'].toString(), list[0]['username'],
        list[0]['fullname'], list[0]['h_pass'], list[0]['bio'], list[0]['avatar']);

    debugPrint("[MODEL] query on $uid, count follower: ${am.toString()}");
    return am;
  }

  AccountModel(this.uid, this.username, this.fullname, this.h_pass, this.bio, this.avatar);
}
