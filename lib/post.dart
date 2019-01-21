import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Post extends StatefulWidget {
  final String postId;

  Post(this.postId);

  bool isLiked() {
    debugPrint("[IMPLMTN] Post am I liked?");
    return false;
  }

  @override
  _PostState createState() => _PostState(isLiked());
}

class _PostState extends State<Post> {
  bool _isLiked;

  _PostState(this._isLiked);

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      debugPrint("[IMPLMNT] toggle like state");
    });
  }

  void _showSenderProfile() {
    // TODO: show a scaffold
    debugPrint("[IMPLMNT] show senderProfile");
  }

  void _showComments() {
    // TODO: a list of comments warped in a scaffold
    debugPrint("[IMPLMNT] show Comments for the Post");
  }

  Widget likeCommentMsgSection() {
    return Row(children: <Widget>[
      GestureDetector(
          onTap: _toggleLike,
          child: Icon(
            (_isLiked) ? Icons.favorite : Icons.favorite_border,
            color: (!_isLiked) ? Colors.black : Colors.red,
            size: 28,
          )),
      GestureDetector(
          onTap: _showComments,
          child: Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: Icon(
                Icons.comment,
                color: Colors.black54,
                size: 28,
              ))),
      Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: Icon(
            Icons.send,
            color: Colors.black54,
            size: 28,
          )),
      Expanded(
          child: Container(
        height: 0,
      )),
      Text(
        "${DateFormat("d MMMM y").format(DateTime.now())}",
        style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          padding: const EdgeInsets.only(top: 4.0, left: 4.0, bottom: 2),
          margin: EdgeInsets.all(4),
          child: GestureDetector(
              onTap: _showSenderProfile,
              child: Row(children: [
                CircleAvatar(),
                Container(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text("Dude", style: TextStyle(fontWeight: FontWeight.bold)))
              ]))),
      Divider(
        height: 0,
        color: Colors.black38,
      ),
      GestureDetector(
          onDoubleTap: () {
            setState(() {
              _isLiked = true;
            });
          },
          child: Image.asset(
            'images/lake.jpg',
            fit: BoxFit.cover,
//          width: 600.0,
//          height: 240.0,
          )),
      Container(
          padding: const EdgeInsets.only(bottom: 12.0, left: 2.0),
          margin: EdgeInsets.all(8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            likeCommentMsgSection(), // row {like comment sendMsg -- Save}
            GestureDetector(
                onTap: () {
                  debugPrint("[IMPLMNT] show likes for post");
                },
                child: Text("7,543 likes", style: TextStyle(fontWeight: FontWeight.bold))),
          ] // n Likes
              // view Comments
              // Time of Creation
              ))
    ]);
  }
}
