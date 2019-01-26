import 'package:flutter/material.dart';
import 'package:instagram_1/model/account.dart';
import 'package:instagram_1/model/following.dart';

class FollowerList extends StatefulWidget {
  static List<AccountModel> _accounts;
  static String uid;

  static Future<List<AccountModel>> get accounts async {
    if (_accounts == null) {
      _accounts = await FollowingModel.getFollowersByUID(uid);
      debugPrint("[FollowerList] _accounts: $_accounts");
    }
    return _accounts;
  }

  FollowerList(String _uid) {
    uid = _uid;
  }

  @override
  State createState() {
    return _FollowerListState();
  }
}

class _FollowerListState extends State<FollowerList> {
  ListTile _addPost(BuildContext context, AccountModel am) {
    return ListTile(
      onTap: () {
        debugPrint("[IMPLMNT] ${am.username}'s profile page");
      },
      leading: Image.asset(am.avatar),
      title: Text(am.username),
    );
  }

  List<Widget> _createChildren(BuildContext context, List<AccountModel> amlist) {
    var ret = List<Widget>();
    for (var am in amlist) {
      ret.add(_addPost(context, am));
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FollowerList.accounts,
      builder: (BuildContext context, AsyncSnapshot<List<AccountModel>> snapshot) {
        return snapshot.hasData
            ? ListView(
                children: _createChildren(context, snapshot.data),
              )
            : CircularProgressIndicator();
        ;
      },
    );
  }
}
