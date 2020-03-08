import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:path/path.dart' as Path;
import '../models/post.dart';

class EntryForm extends StatefulWidget {

  final File image;

  EntryForm({
    Key key,
    @required this.image
  }) : super(key: key);

  @override 
  State createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm> {

  final formKey = GlobalKey<FormState>();
  final postFields = Post();
  LocationData locationData;

  @override 
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: formContainer()
    );
  }

  Widget formContainer() {
    return LayoutBuilder(
      builder: (context, viewport) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: viewport.maxHeight),
            child: IntrinsicHeight(child: Column(children: formFields(context)))
          )
        );
      }
    );
  }

  List<Widget> formFields(BuildContext context) {
    return [
      Image.file(widget.image, height: 300.0),
      SizedBox(height: 10.0),
      numField(),
      SizedBox(height: 10.0),
      buttonContainer(),
    ];
  }
  
  // TODO: add semantics widget
  Widget numField() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Number of Items',
        border: OutlineInputBorder()
      ),
      keyboardType: TextInputType.number,
      onSaved: (value) {
        postFields.numItems = int.parse(value);
      },
      validator: (value) => checkInteger(value)
    );
  }

  Widget buttonContainer() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 100.0,
          width: double.infinity, 
          child: uploadButton()
        )
      ),
    );
  }

  // TODO: add semantics widget
  Widget uploadButton() {
    return RaisedButton(
      child: Icon(Icons.cloud_upload, size: 80.0),
      onPressed: () { savePost(); }
    );
  }

  String checkInteger(String value) {
    if (value.isEmpty || int.tryParse(value) == null) {
      return 'Number of items is invalid';
    } else {
      return null;
    }
  }

  void savePost() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      // Get current date
      postFields.date = DateTime.now();

      // Get current location
      locationData = await Location().getLocation();
      postFields.latitude = locationData.latitude;
      postFields.longitude = locationData.longitude;

      // Upload image to Cloud Storage
      StorageReference storageReference = FirebaseStorage.instance.ref().child(DateTime.now().millisecondsSinceEpoch.toString() + '_' + Path.basename(widget.image.path));
      StorageUploadTask uploadTask = storageReference.putFile(widget.image);
      await uploadTask.onComplete;
      postFields.photoUrl = await storageReference.getDownloadURL();

      // Save post to Firestore
      Firestore.instance.collection('posts').add(postFields.toMap());
      
      Navigator.of(context).pop();
    }
  }
}