import 'package:flutter/material.dart';
import 'package:rucksack/mywidget/homecard.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'homescreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Rucksack'),
          leading: Icon(Icons.menu_rounded),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              HomeItemTile('rolex watch', '1992 spring model', '','','model12A% 1992 watch for sale', Icons.watch),

            ],

          ),
        ),
      ),
    );
  }
}


