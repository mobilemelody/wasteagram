import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import '../screens/add_post.dart';
import '../widgets/posts.dart';

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
          return postsContent();
        } else {
          totalItems = 0;
          return noPostsContent();
        }
      },
    );
  }

  Widget postsContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram - $totalItems'),
        centerTitle: true,
      ),
      body: Posts(posts: posts),
      floatingActionButton: addPostButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget noPostsContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram - $totalItems'),
        centerTitle: true,
      ),
      body: Center(child: CircularProgressIndicator()),
      floatingActionButton: addPostButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // TODO: add semantics widget
  Widget addPostButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, AddPost.routeName);
      }
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
}