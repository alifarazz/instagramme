import 'package:flutter/material.dart';
import 'package:instagram_1/main.dart';
import 'package:instagram_1/post_list.dart';

// TODO: edit profile, Fetch Posts, Liked, Saved

class UserProfile extends StatefulWidget {
  final String uid;

  UserProfile(this.uid);

  @override
  State createState() => UserProfileState(uid);
}

//GlobalKey g_PostLikedSavedGlobalKey = GlobalKey();

class UserProfileState extends State<UserProfile> {
  final String uid;

  UserProfileState(this.uid);

  double _getSizeOfTabs() {
    final RenderBox bottomNavBar = g_bottomNavigationBarKey.currentContext.findRenderObject();
    final sizeNav = bottomNavBar.size;

//    final RenderBox tabs = g_PostLikedSavedGlobalKey.currentContext.findRenderObject();
//    final position = tabs.localToGlobal(Offset.zero);
    return MediaQuery.of(context).size.height - sizeNav.height - 201.2;
  }

  Widget _postLikedSaved() {
    TabController tabController =
        TabController(length: 3, vsync: AnimatedListState(), initialIndex: 0);
    return Container(
      child: Column(
//        key: g_PostLikedSavedGlobalKey ,
        children: <Widget>[
          TabBar(
//            isScrollable: true,
            controller: tabController,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Posts",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Liked",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Saved",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            height: _getSizeOfTabs(),
            child: TabBarView(
              controller: tabController,
              children: <Widget>[PostList(), PostList(), PostList()],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 32,
              ), // Avatar
              Expanded(
                  child: Container(
                height: 0,
              )), // Padding
              GestureDetector(
                  // Followers
                  onTap: () {
                    debugPrint("[IMPLMNT] Show Followers for $uid");
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 32),
                      child: Text(
                        "Followers",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
              GestureDetector(
                  // FOLLOWING
                  onTap: () {
                    debugPrint("[IMPLMNT] Show following for $uid");
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Text(
                        "Following",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
            ],
          )),
      Container(
        // UserName
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.all(16),
        child: Text("Some Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      _postLikedSaved()
    ])));
  }
}
