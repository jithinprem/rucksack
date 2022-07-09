import 'package:flutter/material.dart';
import 'package:rucksack/screens/profile/listofsale.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);
  static String id = 'myorder';

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: ListView(
                  children: TilesSaleList,
                ),),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                     ElevatedButton(
                      onPressed: (){print('ele');},
                      child: Text('just for fun'),
                     )
                    ],
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
