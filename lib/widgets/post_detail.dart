import 'package:flutter/material.dart';
import '../models/post.dart';

class PostDetail extends StatelessWidget {
  final Post post;

  PostDetail({Key key, @required this.post}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: postContent(context)
      ),
    );
  }

  Widget postContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(post.dateString(), style: Theme.of(context).textTheme.display1),
        SizedBox(height: 10.0),
        Image.network(post.photoUrl, height: 300.0),
        SizedBox(height: 10.0),
        Text('Items: ${post.numItems}', style: Theme.of(context).textTheme.subhead),
        SizedBox(height: 10.0),
        Text('(${post.latitude.toString()}, ${post.longitude.toString()})')
      ],
    );
  }
}