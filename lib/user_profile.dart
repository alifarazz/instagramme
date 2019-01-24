import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:instagram_1/main.dart';
import 'package:instagram_1/post_list.dart';

// TODO: edit profile, Fetch Posts, Liked, Saved

class UserProfile extends StatefulWidget {
  final String uid;

  UserProfile(this.uid);

  @override
  State createState() => _UserProfileState(uid);
}

//GlobalKey g_PostLikedSavedGlobalKey = GlobalKey();

class _UserProfileState extends State<UserProfile> with SingleTickerProviderStateMixin {
  final String uid;

  _UserProfileState(this.uid);

//  Widget _postLikedSaved() {
//    return Container(
//      child: Column(
////        key: g_PostLikedSavedGlobalKey ,
//        children: <Widget>[
//          TabBar(
////            isScrollable: true,
//            controller: _tabController,
//            tabs: <Widget>[
//              Tab(
//                child: Text(
//                  "Posts",
//                  style: TextStyle(
//                    color: Colors.black,
//                  ),
//                ),
//              ),
//              Tab(
//                child: Text(
//                  "Liked",
//                  style: TextStyle(
//                    color: Colors.black,
//                  ),
//                ),
//              ),
//              Tab(
//                child: Text(
//                  "Saved",
//                  style: TextStyle(
//                    color: Colors.black,
//                  ),
//                ),
//              ),
//            ],
//          ),
//          Container(
//            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
//            height: 200,
////            alignment: Alignment.bottomCenter,
//            child: TabBarView(
//              controller: _tabController,
//              children: <Widget>[PostList(), PostList(), PostList()],
//            ),
//          ),
//        ],
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: CollapsingList("1")

//				child: CustomScrollView(slivers: [
//					SliverList(
//							delegate: SliverChildListDelegate([

////								_postLikedSaved()
//							])),
//					SliverFixedExtentList(
//							itemExtent: 150.0,
//							delegate: SliverChildListDelegate(
//								[
//									Container(color: Colors.red),
//									Container(color: Colors.purple),
//									Container(color: Colors.green),
//									Container(color: Colors.orange),
//									Container(color: Colors.yellow),
//									Container(color: Colors.pink),
//								],
//							)),
//				])
        );
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

class CollapsingList extends StatelessWidget {
  CollapsingList(this.uid);

  final String uid;

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
    return CustomScrollView(
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
                    child: Text("@Some Name",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
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
                          child: Column(children: [
                            Text(
                              "Followers",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  "67",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600, color: Colors.black45),
                                ))
                          ]))),
                  GestureDetector(
                    // FOLLOWING
                    onTap: () {
                      debugPrint("[IMPLMNT] Show following for $uid");
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
                                  "67",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600, color: Colors.black45),
                                ))
                          ],
                        )),
                  ),
                ]))),
        SliverPadding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            sliver: SliverToBoxAdapter(
                child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                style: TextStyle(color: Colors.grey),))),
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
    );
  }
}
