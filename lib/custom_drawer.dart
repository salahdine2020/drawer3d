import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class FlipDrawerDemo extends StatefulWidget {
  @override
  _FlipDrawerDemoState createState() => _FlipDrawerDemoState();
}

class _FlipDrawerDemoState extends State<FlipDrawerDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final double maxSlide = 225.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  void toggleDrawer() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: <Widget>[
          buildDrawer(),
          buildScaffold(),
        ],
      ),
    );
  }

  Widget buildScaffold() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double slide = maxSlide * _animationController.value;
        double scale = 1 - (_animationController.value * 0.3);

        return Transform(
          transform: Matrix4.identity()
            ..translate(slide)
            ..rotateY(-pi / 2 * _animationController.value),
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              if (_animationController.isCompleted) {
                toggleDrawer();
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('Hello Flutter'),
              ),
              body: Center(
                child: Text('3D Flip Scaffold'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: toggleDrawer,
                child: Icon(Icons.info_outline, size: 28,),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildDrawer() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double slide = maxSlide * (_animationController.value - 1);
        return Transform.translate(
          offset: Offset(slide, 0),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(pi / 2 * (1 - _animationController.value)),
            alignment: Alignment.centerRight,
            child: Drawer(
              child: Column(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text("Flutter 3D"),
                    accountEmail: Text("salahinetelecom@gmail.com"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: InkWell(
                        onTap: toggleDrawer,
                        child: Text("FE"),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Item 1"),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Item 2"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
