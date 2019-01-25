import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:instagram_1/feed.dart';
import 'package:instagram_1/post_list.dart';
import 'package:instagram_1/pages/user_profile.dart';
import 'package:instagram_1/pages/login_page.dart';
import 'package:instagram_1/pages/sign_up_page.dart';
import 'package:instagram_1/pages/home_page.dart';
import 'package:instagram_1/pages/edit_profile.dart';
import 'package:instagram_1/shared_prefs.dart';

import 'package:instagram_1/model/account.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
//static AccountModel accountModel;
//
//  static String get loginUID {
//    if (accountModel == null)
//      return '';
//    return accountModel.uid;
//  }

  static String loginUID;

  // This widget is the root of your application.
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    RootPage.tag: (context) => RootPage(),
    SignUpPage.tag: (context) => SignUpPage(),
    HomePage.tag: (context) => HomePage(),
    EditProfilePage.tag: (context) => EditProfilePage(),
  };

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
        primarySwatch: Colors.blue,
//        fontFamily: 'Nunito',
      ),
      home: RootPage(title: 'Instagram'),
      routes: routes,
    );
  }
}

class RootPage extends StatefulWidget {
  RootPage({Key key, this.title}) : super(key: key);
  final String title;
  static String tag = 'root-page';

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Future<String>  _getLoginUID() async {
    return (await MySharedPrefs.prefs).getString('uid');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _getLoginUID(),
        builder: (BuildContext ctx, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading ...');
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else {
                MyApp.loginUID = snapshot.data;
                debugPrint("[BUILD] uid = ${MyApp.loginUID}");
                if (MyApp.loginUID == '1')
                  return HomePage();
                else {
                  return LoginPage();
                }
              }
          }
        });
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
//
//class TabNavigatorRoutes {
//// TODO: add 'create post' route
//	static const root = '/';
//
//	static const feed = '/feed';
//	static const global = '/global';
//	static const recent = '/recent';
//	static const profile = '/profile';
//}
//
//class TabNavigator extends StatelessWidget {
//	TabNavigator({this.navigatorKey, this.tabItem});
//
//	final GlobalKey<NavigatorState> navigatorKey;
//	final TabItem tabItem;
//
//	Map<String, WidgetBuilder> _routeBuilders(BuildContext ctx, {String uid: "1"}) {
//		return {
//			TabNavigatorRoutes.root: (ctx) => Feed(),
//			TabNavigatorRoutes.feed: (ctx) => Feed(),
//			TabNavigatorRoutes.global: (ctx) => Feed(),
//			TabNavigatorRoutes.recent: (ctx) => PostList(),
//			TabNavigatorRoutes.profile: (ctx) => UserProfile(uid)
//		};
//	}
//
//	@override
//	Widget build(BuildContext context) {
//		var routeBuilders = _routeBuilders(context);
//		return Navigator(
//				key: navigatorKey,
//				initialRoute: TabNavigatorRoutes.feed,
//				onGenerateRoute: (routeSettings) {
//					debugPrint('routeSettings.name ${routeSettings.name}');
//					return MaterialPageRoute(
//							builder: (context) => routeBuilders[routeSettings.name](context));
//				});
//	}
//}
