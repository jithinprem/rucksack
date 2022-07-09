import 'package:flutter/material.dart';
import 'package:rucksack/screens/profile/listofsale.dart';

class SalesList extends StatefulWidget {
  const SalesList({Key? key}) : super(key: key);
  static String id = 'saleslist';

  @override
  State<SalesList> createState() => _SalesListState();
}

class _SalesListState extends State<SalesList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('SalesList'),),
          body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: ListView(
                      children: TilesSaleList
                  ),
                ),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(onPressed: (){print('nothing');}, child: Text('nothing pressed')),
                        ElevatedButton(onPressed: (){print('nothing');}, child: Text('nothing pressed')),

                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
