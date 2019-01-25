import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:instagram_1/main.dart';
import 'package:instagram_1/pages/login_page.dart';
import 'package:instagram_1/post_list.dart';
import 'package:instagram_1/shared_prefs.dart';
import 'package:instagram_1/pages/edit_profile.dart';
import 'package:instagram_1/model/db/dbhelper.dart';
import 'package:instagram_1/model/following.dart';
import 'package:instagram_1/model/account.dart';

// TODO: edit profile, Fetch Posts, Liked, Saved

class UserProfile extends StatefulWidget {
  @override
  State createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    debugPrint("[BUILD] create user profile with uid: ${MyApp.loginUID}");
    return SafeArea(child: CollapsingList());
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({this.minHeight, this.maxHeight, this.child});

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: this.child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CollapsingList extends StatefulWidget {
  @override
  State createState() => _CollapsingListState();
}

class _CollapsingListState extends State<CollapsingList> {
  AccountModel accountModel;

  Future<AccountModel> setAccountModel() async {
    accountModel = await AccountModel.getByUID(MyApp.loginUID);
    return accountModel;
  }

  Widget _createDrawer() {
    return ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
        child: Center(child: Text("Built in 3 days\nwith sweet and tears.")),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
      ),
      ListTileTheme(
          textColor: Colors.orange,
          style: ListTileStyle.drawer,
          child: ListTile(
            title: Text("Edit Profile"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(EditProfilePage.tag);
            },
          )),
      ListTileTheme(
          textColor: Colors.orange,
          style: ListTileStyle.drawer,
          child: ListTile(
            title: Text("Logout"),
            onTap: () {
              MySharedPrefs.prefs.then((prefs) {
                prefs.setString("uid", null);
                MyApp.loginUID = null;
              });
              Navigator.of(context).pushReplacementNamed(LoginPage.tag);
            },
          )),
      ListTileTheme(
          textColor: Colors.orange,
          style: ListTileStyle.drawer,
          child: ListTile(
              title: Text("Create DB"),
              onTap: () {
                DBHelper().db.then((db) {
                  debugPrint("Database Called");
                });
              })),
    ]);
  }

  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverAppBarDelegate(
            maxHeight: 30.0,
            minHeight: 40.0,
            child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Divider(
                      height: 0,
                      color: Colors.black54,
                    ),
                    Text(headerText),
                    Divider(
                      height: 0,
                      color: Colors.white.withOpacity(1),
                    ),
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("[BUILD] the accountmodel: $accountModel");
    return FutureBuilder(
      future: setAccountModel(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? (Scaffold(
                endDrawer: _createDrawer(),
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                        child: Image.asset(
                      'images/lake.jpg',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.width / 4 * 3,
                    )),
                    SliverToBoxAdapter(
                        child: Container(
                            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                            child: Row(children: <Widget>[
//                  CircleAvatar(
//                    radius: 32,
//                  ), // Avatar
                              Container(
                                /* UserName */
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Text(accountModel.username,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              ),
                              Expanded(
                                  child: Container(
                                height: 0,
                              )), // Padding
                              GestureDetector(
                                  // Followers
                                  onTap: () {
                                    debugPrint("[IMPLMNT] Show Followers for ${MyApp.loginUID}");
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(right: 32),
                                      child: Column(children: [
                                        Text(
                                          "Followers",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text(
                                              () {
                                                int cnt = 0;
                                                FollowingModel.getFollowerCountByUID(MyApp.loginUID)
                                                    .then((value) {
                                                  cnt = value;
                                                });
                                                return cnt.toString();
                                              }(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black45),
                                            ))
                                      ]))),
                              GestureDetector(
                                // FOLLOWING
                                onTap: () {
                                  debugPrint("[IMPLMNT] Show following for ${MyApp.loginUID}");
                                },
                                child: Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Following",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text(
                                              () {
                                                int cnt = 0;
                                                FollowingModel.getFollowingCountByUID(
                                                        MyApp.loginUID)
                                                    .then((value) {
                                                  cnt = value;
                                                });
                                                return cnt.toString();
                                              }(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black45),
                                            ))
                                      ],
                                    )),
                              ),
                            ]))),
                    SliverPadding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        sliver: SliverToBoxAdapter(
                            child: Text(
                          accountModel.bio,
                          style: TextStyle(color: Colors.grey),
                        ))),
                    makeHeader('Header Section 1'),
                    SliverGrid.count(
                      crossAxisCount: 3,
                      children: <Widget>[
                        Container(color: Colors.red, height: 150.0),
                        Container(color: Colors.purple, height: 150.0),
                        Container(color: Colors.green, height: 150.0),
                        Container(color: Colors.orange, height: 150.0),
                        Container(color: Colors.yellow, height: 150.0),
                        Container(color: Colors.pink, height: 150.0),
                        Container(color: Colors.cyan, height: 150.0),
                        Container(color: Colors.indigo, height: 150.0),
                        Container(color: Colors.blue, height: 150.0),
                      ],
                    ),
                    makeHeader('Header Section 2'),
                    SliverFixedExtentList(
                      itemExtent: 150.0,
                      delegate: SliverChildListDelegate(
                        [
                          Container(color: Colors.red),
                          Container(color: Colors.purple),
                          Container(color: Colors.green),
                          Container(color: Colors.orange),
                          Container(color: Colors.yellow),
                        ],
                      ),
                    ),
                    makeHeader('Header Section 3'),
                    SliverGrid(
                      gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 4.0,
                      ),
                      delegate: new SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return new Container(
                            alignment: Alignment.center,
                            color: Colors.teal[100 * (index % 9)],
                            child: new Text('grid item $index'),
                          );
                        },
                        childCount: 20,
                      ),
                    ),
                    makeHeader('Header Section 4'),
                    // Yes, this could also be a SliverFixedExtentList. Writing
                    // this way just for an example of SliverList construction.
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Container(color: Colors.pink, height: 150.0),
                          Container(color: Colors.cyan, height: 150.0),
                          Container(color: Colors.indigo, height: 150.0),
                          Container(color: Colors.blue, height: 150.0),
                        ],
                      ),
                    ),
                  ],
                )))
            : CircularProgressIndicator();
      },
    );
  }
}
