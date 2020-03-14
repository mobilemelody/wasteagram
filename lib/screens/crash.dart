import 'package:flutter/material.dart';

class Crash extends StatelessWidget {

  static final routeName = 'crash';

  @override 
  Widget build(BuildContext context) {
    throw StateError('Test Error');
  }
}