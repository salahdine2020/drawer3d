import 'dart:math';
import 'package:flutter/material.dart';

import 'custom_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Flip Drawer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlipDrawerDemo(),
    );
  }
}

