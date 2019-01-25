import 'package:flutter/material.dart';

import 'package:instagram_1/feed.dart';
import 'package:instagram_1/post_list.dart';
import 'package:instagram_1/pages/user_profile.dart';
import 'package:instagram_1/pages/login_page.dart';
import 'package:instagram_1/pages/sign_up_page.dart';
import 'package:instagram_1/main.dart';


class HomePage extends StatefulWidget {
	static String tag = 'home-page';

	@override
	_HomePageState createState() => _HomePageState();
}
enum TabItem { Feed, Global, Recent, Profile }

class _HomePageState extends State<StatefulWidget> {
	final List<Widget> _children = [Feed(), Feed(), PostList(), UserProfile(MyApp.loginUID)];
	TabItem _currentTab = TabItem.Feed;

	void _selectTab(int idx) {
		setState(() {
			_currentTab = TabItem.values[idx];
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			resizeToAvoidBottomPadding: false,
			body: _children[_currentTab.index],
			bottomNavigationBar: BottomNavigationBar(
				items: _bottomNavBarItems(),
				onTap: _selectTab,
				currentIndex: _currentTab.index,
			),
		);
	} //  Map<TabItem, GlobalKey<NavigatorState>> navigatorKey = {
//    TabItem.Global: GlobalKey<NavigatorState>(),
//    TabItem.Recent: GlobalKey<NavigatorState>(),
//    TabItem.Profile: GlobalKey<NavigatorState>(),
//    TabItem.Feed: GlobalKey<NavigatorState>(),
//  };


//
//	Widget _buildOffstageNavigator(TabItem tabItem) {
//		return Offstage(
//			offstage: _currentTab != tabItem,
//			child: TabNavigator(
//				navigatorKey: navigatorKey[tabItem],
//				tabItem: tabItem,
//			),
//		);
//	}

//	Widget _buildBody() {
//		return  Container(
//				color: Colors.white, // ??
//				alignment: Alignment.center,
//				child: FlatButton(child: Text("PUSH"),)
//		);
//		return PageView(
//			children: <Widget>[
//				Container(color: Colors.white, child: _Feed),
//				Container(
//					color: Colors.white,
//					child: _GobalFeed,
//				),
//				Container(color: Colors.white, child: _Log),
//				Container(color: Colors.white, child: _Profile),
//			],
//			controller: pageController,
//			physics: NeverScrollableScrollPhysics(),
//			onPageChanged: _onPageChanged,
//		);

	List<BottomNavigationBarItem> _bottomNavBarItems() {
		return <BottomNavigationBarItem>[
			BottomNavigationBarItem(
					icon: Icon(Icons.home, color: (_currentTab == TabItem.Feed) ? Colors.white : Colors.grey),
					title: Text("Feed"),
					backgroundColor: Colors.black),
			BottomNavigationBarItem(
					icon: Icon(Icons.search,
							color: (_currentTab == TabItem.Global) ? Colors.white : Colors.grey),
					title: Text("Global"),
					backgroundColor: Colors.black),
			BottomNavigationBarItem(
					icon: Icon(Icons.history,
							color: (_currentTab == TabItem.Recent) ? Colors.white : Colors.grey),
					title: Text("Recent"),
					backgroundColor: Colors.black),
			BottomNavigationBarItem(
					icon: Icon(Icons.person,
							color: (_currentTab == TabItem.Profile) ? Colors.white : Colors.grey),
					title: Text("Profile"),
					backgroundColor: Colors.black)
		];
	}

}