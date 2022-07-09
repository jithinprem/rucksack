import 'package:flutter/material.dart';

import 'listofsale.dart';

class WishList extends StatefulWidget {
  static String id = 'wishlist';
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
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
                  flex: 6,
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
