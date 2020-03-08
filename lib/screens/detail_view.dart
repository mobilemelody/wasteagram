import 'package:flutter/material.dart';
import '../models/post.dart';
import '../widgets/post_detail.dart';

class DetailView extends StatelessWidget {

  static final routeName = 'post';

  @override 
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
      ),
      body: PostDetail(post: post),
    );
  }
}