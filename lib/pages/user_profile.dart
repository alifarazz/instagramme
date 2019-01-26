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
import 'package:instagram_1/pages/follower_list.dart';

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
//              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
							Navigator.of(context).pushReplacementNamed(EditProfilePage.tag);
						},
					)),
			ListTileTheme(
					textColor: Colors.orange,
					style: ListTileStyle.drawer,
					child: ListTile(
						title: Text("Logout"),
						onTap: () async {
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

	_createFollowersCount(String uid) {
		return FutureBuilder(
			future: FollowingModel.getFollowerCountByUID(uid),
			builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
				return snapshot.hasData ? Text(snapshot.data.toString(),
					style: TextStyle(
							fontWeight: FontWeight.w600,
							color: Colors.black45),
				): CircularProgressIndicator();
			},
		);
	}

	_createFollowingCount(String uid) {
		return FutureBuilder(
			future: FollowingModel.getFollowingCountByUID(uid),
			builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
				return snapshot.hasData ? Text(snapshot.data.toString(),
					style: TextStyle(
							fontWeight: FontWeight.w600,
							color: Colors.black45),
				): CircularProgressIndicator();
			},
		);
	}


	@override
	Widget build(BuildContext context) {
		debugPrint("[BUILD] the accountmodel: $accountModel");

		_showFollowers(BuildContext context, String uid) {
//      List<AccountModel> followers = ;
			Navigator.push(
					context, MaterialPageRoute(builder: (context) => Scaffold(body: FollowerList(uid))));
		}

		return FutureBuilder(
			future: setAccountModel(),
			builder: (BuildContext context, AsyncSnapshot<AccountModel> snapshot) {
				return snapshot.hasData
						? (Scaffold(
						endDrawer: snapshot.data.uid == MyApp.loginUID ? _createDrawer() : null,
						// set this to current uid
						body: CustomScrollView(
							slivers: <Widget>[
								SliverToBoxAdapter(
										child: Image.asset(
											'images/lake.jpg',
											fit: BoxFit.cover,
											height: MediaQuery
													.of(context)
													.size
													.width / 4 * 3,
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
														margin: const EdgeInsets.only(bottom: 20, top: 4),
														child:
														Column(mainAxisAlignment: MainAxisAlignment.start, children: [
															Text('@' + accountModel.username,
																	style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
															Text(accountModel.fullname, style: TextStyle(fontSize: 10))
														]),
													),
													Expanded(
															child: Container(
																height: 0,
															)), // Padding
													GestureDetector(
														// Followers
															onTap: () async {
																await _showFollowers(context, snapshot.data.uid);
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
																				child: _createFollowersCount(snapshot.data.uid))
																	]))),
													GestureDetector(
														// FOLLOWING
														onLongPress: () {
															Navigator.push(
																	context,
																	MaterialPageRoute(
																			builder: (context) => Scaffold(body: PostList())));
														},
														onTap: () {
															debugPrint("[IMPLMNT] Show following for ${snapshot.data.uid}");
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
																				child: _createFollowingCount(snapshot.data.uid))
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
								makeHeader('Posts'),
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
								makeHeader('Saved Posts'),
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
							],
						)))
						: CircularProgressIndicator();
			},
		);
	}
}
