import 'package:flutter/material.dart';
import 'package:rucksack/screens/additem.dart';

class UpdateDetail extends StatefulWidget {
  const UpdateDetail({Key? key}) : super(key: key);
  static String id = 'updatedetail';

  @override
  State<UpdateDetail> createState() => _UpdateDetailState();
}

class _UpdateDetailState extends State<UpdateDetail> {

  TextEditingController nameController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Profile'),),
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1656568740683-e48fbeeaf4b6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80'),
                      radius: 60,
                    ),
                    Container(
                      color: Colors.black38,
                      padding: EdgeInsets.all(13),
                      child: Text('editimage'),
                    )
                  ],
                ),
                TextF(nameController: nameController, stri: 'name'),
                TextF(nameController: batchController, stri: 'batch'),
                TextF(nameController: yearController, stri: 'year'),
                ElevatedButton(onPressed: (){print('hello');}, child: Text('submit')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
