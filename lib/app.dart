import 'package:flutter/material.dart';
import 'screens/posts_view.dart';
import 'screens/detail_view.dart';
import 'screens/add_post.dart';

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final routes = {
      PostsView.routeName: (context) => PostsView(),
      DetailView.routeName: (context) => DetailView(),
      AddPost.routeName: (context) => AddPost(),
    };
    
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes
    );
  }
}