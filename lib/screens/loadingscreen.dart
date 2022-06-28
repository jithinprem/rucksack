import 'package:flutter/material.dart';

class LoadingScreen1 extends StatefulWidget {
  const LoadingScreen1({Key? key}) : super(key: key);

  @override
  State<LoadingScreen1> createState() => _LoadingScreen1State();
}

class _LoadingScreen1State extends State<LoadingScreen1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            child: Center(child: Text('loading...'),),
          ),
        ),
      ),
    );
  }
}
