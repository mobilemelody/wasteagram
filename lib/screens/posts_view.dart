import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import '../screens/add_post.dart';
import '../screens/crash.dart';
import '../widgets/posts.dart';
import '../widgets/firebase_analytics.dart';

class PostsView extends StatefulWidget {

  static final routeName = '/';

  @override 
  State createState() => PostsViewState();
}

class PostsViewState extends State<PostsView> {
  
  int totalItems;
  List<Post> posts;

  @override 
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.documents.length > 0) {
          posts = snapshotToPost(snapshot.data.documents);
          posts.sort((b, a) => a.date.compareTo(b.date));
          getTotalItems();
          return postsContent(Posts(posts: posts));
        } else {
          totalItems = 0;
          return postsContent(Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget postsContent(Widget body) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram - $totalItems'),
        centerTitle: true,
        actions: <Widget>[crashButton()],
      ),
      body: body,
      floatingActionButton: addPostButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget addPostButton(BuildContext context) {
    return Semantics(
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddPost.routeName);
        }
      ),
      label: 'Add post button',
      button: true,
      enabled: true,
      onTapHint: 'Tap to add a post'
    );
  }

  List<Post> snapshotToPost(List<DocumentSnapshot> snapshot) {
    List<Post> posts = [];
    snapshot.forEach((e) {
      posts.add(Post(
        photoUrl: e['photoUrl'],
        numItems: e['numItems'],
        latitude: e['latitude'],
        longitude: e['longitude'],
        date: e['date'].toDate()
      ));
    });
    return posts;
  }

  void getTotalItems() {
    totalItems = 0;
    posts.forEach((e) {
      totalItems += e.numItems;
    });
  }

  Widget crashButton() {
    return IconButton(
      icon: Icon(Icons.error),
      tooltip: 'Crash App',
      onPressed: () {
        analytics.logEvent(name: 'crash_app');
        Navigator.pushNamed(context, Crash.routeName);
      }
    );
  }
}