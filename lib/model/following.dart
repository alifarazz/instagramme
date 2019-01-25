import 'account.dart';
import 'db/dbhelper.dart';
import 'package:flutter/material.dart';

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
    await dbClient.transaction((txn) async {
      return await txn.rawInsert('''INSERT into FOLLOWING (follower, followee)
      VALUES(?, ?)''', [this.follower.uid, this.followee.uid]);
    });
  }

  static Future<int> getFollowerCountByUID(String uid) async {
    var dbClient = await DBHelper().db;
    List<Map> list = await dbClient.rawQuery('''SELECT count(*) as flcnt
    FROM FOLLOWING
    WHERE FOLLOWING.followee = ?;''', [uid]);
    int count = 0;
    if (list.isNotEmpty) count = list[0]["flcnt"];
    debugPrint("query on $uid, count followee: $count");
    return count;
  }

  static Future<int> getFollowingCountByUID(String uid) async {
    var dbClient = await DBHelper().db;
    List<Map> list = await dbClient.rawQuery('''SELECT count(*) as flcnt 
    FROM FOLLOWING
    WHERE FOLLOWING.follower = ?;''', [uid]);
    int count = 0;
    if (list.isNotEmpty) count = list[0]["flcnt"];
    debugPrint("[MODEL] query on $uid, count follower: $count");
    return count;
  }

  static Future<List<AccountModel>> getFollowersByUID(String uid) async {
    var dbClient = await DBHelper().db;
    List<Map> list = await dbClient.rawQuery('''
    SELECT uid, username,fullname, h_pass, bio, avatar 
    FROM FOLLOWING, ACCOUNT
    WHERE FOLLOWING.followee = ? and ACCOUNT.uid = ?;''', [uid, uid]);

    List<AccountModel> am;
    for (var q in list)
      am.add(
          AccountModel(q['uid'], q['username'], q['fullname'], q['h_pass'], q['bio'], q['avatar']));
    debugPrint("query on $uid, get follwers: ${am.toString()}");
    return am;
  }

  static Future<List<AccountModel>> getFollowingsByUID(String uid) async {
    var dbClient = await DBHelper().db;
    List<Map> list = await dbClient.rawQuery('''
    SELECT uid, username,fullname, h_pass, bio, avatar 
    FROM FOLLOWING, ACCOUNT
    WHERE FOLLOWING.follower = ? and ACCOUNT.uid = ?;''', [uid, uid]);

    List<AccountModel> am;
    for (var q in list)
      am.add(
          AccountModel(q['uid'], q['username'], q['fullname'], q['h_pass'], q['bio'], q['avatar']));
    debugPrint("query on $uid, get follwing: ${am.toString()}");
    return am;
  }

  FollowingModel(this.followee, this.follower);
}
