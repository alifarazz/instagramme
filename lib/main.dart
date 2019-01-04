import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_1/feed.dart';
import 'package:instagram_1/post_list.dart';
import 'package:instagram_1/user_profile.dart';

void main() => runApp(MyApp());

PageController pageController = PageController(initialPage: 0, keepPage: true);

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  Widget _Feed = Feed(), _GobalFeed = Feed(), _Profile = UserProfile("1"), _Log = PostList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(),
      body: PageView(
        children: <Widget>[
          Container(color: Colors.white, child: _Feed),
          Container(
            color: Colors.white,
            child: _GobalFeed,
          ),
          Container(color: Colors.white, child: _Log),
          Container(color: Colors.white, child: _Profile),
        ],
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: (_page == 0) ? Colors.white : Colors.grey),
              title: Container(height: 0),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: (_page == 1) ? Colors.white : Colors.grey),
              title: Container(height: 0),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.history, color: (_page == 2) ? Colors.white : Colors.grey),
              title: Container(height: 0),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: (_page == 3) ? Colors.white : Colors.grey),
              title: Container(height: 0),
              backgroundColor: Colors.black)
        ],
        onTap: _onNavigationBarTapped,
        currentIndex: _page,
      ),
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  void _onNavigationBarTapped(int page) {
    pageController.jumpToPage(page);
  }
}
