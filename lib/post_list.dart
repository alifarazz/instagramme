import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  ListTile _addPost(BuildContext context, int i) {
    return ListTile(
      leading: Icon(Icons.timeline),
      title: Text(i.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[_addPost(context, 1), _addPost(context, 2), _addPost(context, 3)],
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
