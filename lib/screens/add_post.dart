import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/entry_form.dart';
import '../widgets/firebase_analytics.dart';

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

  Widget photoButtons() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          choosePhotoButton(),
          takePhotoButton()
        ]
      ),
    );
  }

  Widget choosePhotoButton() {
    return Semantics(
      child: RaisedButton(
        child: Text('Choose Photo'), 
        onPressed: () { choosePhoto(); }
      ),
      label: 'Choose photo button',
      button: true,
      enabled: true,
      onTapHint: 'Opens the gallery to select a photo',
    );
  }

  Widget takePhotoButton() {
    return Semantics(
      child: RaisedButton(
        child: Text('Take Photo'), 
        onPressed: () { takePhoto(); }
      ),
      label: 'Take photo button',
      button: true,
      enabled: true,
      onTapHint: 'Opens the camera to take a photo',
    );
  }

  void choosePhoto() async {
    analytics.logEvent(name: 'pick_image');
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() { });
  }

  void takePhoto() async {
    analytics.logEvent(name: 'take_photo');
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() { });
  }

}