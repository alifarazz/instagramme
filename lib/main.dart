import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:instagram_1/feed.dart';
import 'package:instagram_1/post_list.dart';
import 'package:instagram_1/user_profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Instagram',
			theme: ThemeData(
				// This is the theme of your application.
				//
				// Try running your application with "flutter run". You'll see the
				// application has a blue toolbar. Then, without quitting the app, try
				// changing the primarySwatch below to Colors.green and then invoke
				// "hot reload" (press "r" in the console where you ran "flutter run",
				// or simply save your changes to "hot reload" in a Flutter IDE).
				// Notice that the counter didn't reset back to zero; the application
				// is not restarted.
					primarySwatch: Colors.blue),
			home: MyHomePage(title: 'Instagram'),
		);
	}
}

class MyHomePage extends StatefulWidget {
	MyHomePage({Key key, this.title}) : super(key: key);
	final String title;

	@override
	_MyHomePageState createState() => _MyHomePageState();
}

enum TabItem { Feed, Global, Recent, Profile }

class _MyHomePageState extends State<MyHomePage> {
	TabItem _currentTab = TabItem.Feed;
	Map<TabItem, GlobalKey<NavigatorState>> navigatorKey = {
		TabItem.Global: GlobalKey<NavigatorState>(),
		TabItem.Recent: GlobalKey<NavigatorState>(),
		TabItem.Profile: GlobalKey<NavigatorState>(),
		TabItem.Feed: GlobalKey<NavigatorState>(),
	};
	final List<Widget> _children = [Feed(), Feed(), PostList(), UserProfile("1")];

	void _selectTab(int idx) {
		setState(() {
			_currentTab = TabItem.values[idx];
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
//      appBar: AppBar(),
//      body: TabNavigator(
//        navigatorKey: navigatorKey[TabItem.Global],
//        tabItem: _currentTab,
//      ),
			body: _children[_currentTab.index],
			bottomNavigationBar: BottomNavigationBar(
				items: _bottomNavBarItems(),
				onTap: _selectTab,
				currentIndex: _currentTab.index,
			),
		);
	}

	Widget _buildOffstageNavigator(TabItem tabItem) {
		return Offstage(
			offstage: _currentTab != tabItem,
			child: TabNavigator(
				navigatorKey: navigatorKey[tabItem],
				tabItem: tabItem,
			),
		);
	}

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

	@override
	void initState() {
		super.initState();
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitDown,
			DeviceOrientation.portraitUp,
		]);
	}

	@override
	dispose() {
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.landscapeRight,
			DeviceOrientation.landscapeLeft,
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
		]);
		super.dispose();
	}
}

class TabNavigatorRoutes {
// TODO: add 'create post' route
	static const root = '/';

	static const feed = '/feed';
	static const global = '/global';
	static const recent = '/recent';
	static const profile = '/profile';
}

class TabNavigator extends StatelessWidget {
	TabNavigator({this.navigatorKey, this.tabItem});

	final GlobalKey<NavigatorState> navigatorKey;
	final TabItem tabItem;

	Map<String, WidgetBuilder> _routeBuilders(BuildContext ctx, {String uid: "1"}) {
		return {
			TabNavigatorRoutes.root: (ctx) => Feed(),
			TabNavigatorRoutes.feed: (ctx) => Feed(),
			TabNavigatorRoutes.global: (ctx) => Feed(),
			TabNavigatorRoutes.recent: (ctx) => PostList(),
			TabNavigatorRoutes.profile: (ctx) => UserProfile(uid)
		};
	}

	@override
	Widget build(BuildContext context) {
		var routeBuilders = _routeBuilders(context);
		return Navigator(
				key: navigatorKey,
				initialRoute: TabNavigatorRoutes.feed,
				onGenerateRoute: (routeSettings) {
					debugPrint('routeSettings.name ${routeSettings.name}');
					return MaterialPageRoute(
							builder: (context) => routeBuilders[routeSettings.name](context));
				});
	}
}
