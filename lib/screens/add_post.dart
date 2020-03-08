import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/entry_form.dart';

class AddPost extends StatefulWidget {

  static final routeName = 'add_post';

  @override 
  State createState() => AddPostState();

}

class AddPostState extends State<AddPost> {
  
  File image;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
      ),
      body: addPostBody(),
    );
  }

  Widget addPostBody() {
    if (image == null) {
      return photoButtons();
    } else {
      return EntryForm(image: image);
    }
  }

  // TODO: add semantics widget
  Widget photoButtons() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(child: Text('Choose Photo'), onPressed: () { choosePhoto(); }),
          RaisedButton(child: Text('Take Photo'), onPressed: () { takePhoto(); })
        ]
      ),
    );
  }

  void choosePhoto() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() { });
  }

  void takePhoto() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() { });
  }

}