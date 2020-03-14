import 'package:flutter/material.dart';
import '../models/post.dart';
import '../screens/detail_view.dart';

class Posts extends StatelessWidget{
  
  final List<Post> posts;

  Posts({
    Key key, 
    @required this.posts
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return listTile(context, index);
      },
    );
  }

  Widget listTile(BuildContext context, int index) {
    return Semantics(
      child: ListTile(
        title: Text(posts[index].dateString()),
        trailing: numberIcon(posts[index].numItems),
        onTap: () { Navigator.pushNamed(
          context, 
          DetailView.routeName, 
          arguments: posts[index]
        ); }
      ),
      label: 'An individual post',
      enabled: true,
      onTapHint: 'Tap to see post details'
    );
  }

  Widget numberIcon(int num) {
    return Container(
      child: Text('$num'),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        shape: BoxShape.circle
      ),
    );
  }
}