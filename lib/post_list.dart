import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  ListTile _addPost(BuildContext context, int i){
      return ListTile(
        leading: Icon(Icons.timeline),
        title: Text(i.toString()),

      );
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _addPost,
      scrollDirection: Axis.vertical,

    );
  }
}
