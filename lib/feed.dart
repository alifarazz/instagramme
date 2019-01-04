import 'package:flutter/material.dart';
import 'package:instagram_1/post.dart';

class Feed extends StatefulWidget {
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Post> feedData;

  @override
  void initState() {
    super.initState();
    this._loadFeed();
  }

  buildFeed() {
    if (feedData == null) {
      // show circular progress-bar
      return Container(
        alignment: FractionalOffset.center,
        child: CircularProgressIndicator(),
      );
    }
    return ListView(children: feedData);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: RefreshIndicator(child: buildFeed(), onRefresh: _refresh),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("[IMPLMNT] Add new Post");
        },
        tooltip: 'New Post',
        child: Icon(Icons.add),
        elevation: 2.0,
        backgroundColor: Colors.black,
      ),
    );
  }

  Future<Null> _refresh() async {
//    await _getFeed();
    await _loadFeed();
    setState(() {});
    return;
  }

  _loadFeed() async {
    setState(() {
      feedData = [Post("0"), Post("1"), Post("2"), Post("3")];
    });
  }

//  _getFeed() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//
//    String userId = googleSignIn.currentUser.id.toString();
//    var url = 'https://us-central1-mp-rps.cloudfunctions.net/getFeed?uid=' + userId;
//    var httpClient = new HttpClient();
//
//    List<ImagePost> listOfPosts;
//    String result;
//    try {
//      var request = await httpClient.getUrl(Uri.parse(url));
//      var response = await request.close();
//      if (response.statusCode == HttpStatus.OK) {
//        String json = await response.transform(utf8.decoder).join();
//        prefs.setString("feed", json);
//        List<Map<String, dynamic>> data = jsonDecode(json).cast<Map<String, dynamic>>();
//        listOfPosts = _generateFeed(data);
//      } else {
//        result = 'Error getting a feed:\nHttp status ${response.statusCode}';
//      }
//    } catch (exception) {
//      result = 'Failed invoking the getFeed function. Exception: $exception';
//    }
//    print(result);
//
//    setState(() {
//      feedData = listOfPosts;
//    });
//  }
//
//  List<Post> _generateFeed(List<Map<String, dynamic>> feedData) {
//    List<Post> listOfPosts = [];
//
//    for (var postData in feedData) {
//      listOfPosts.add(new Post.fromJSON(postData));
//    }
//    return listOfPosts;
//  }
}
