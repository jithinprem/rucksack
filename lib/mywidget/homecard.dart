import 'package:flutter/material.dart';

class HomeItemTile extends StatelessWidget {
  var maintitle;
  var subtitle;
  var pic;
  var profpic;
  var desc;
  IconData ic;
  HomeItemTile(this.maintitle,this.subtitle,this.pic, this.profpic,this.desc, this.ic){
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child:  Card(
        child: InkWell(
          onTap: () {
            print("tapped");
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                tileColor: Colors.blueGrey[900],
                leading: Icon(ic, size: 45),
                title: Text(maintitle),
                subtitle: Text(subtitle),
                trailing: CircleAvatar(
                  backgroundImage: NetworkImage(profpic),
                  radius: 28,
                ),
              ),
              Container(
                child: Image.network(pic, fit: BoxFit.fill, height: 240, width: double.infinity,),
              ),
              Container(
                child: ListTile(
                  title: Text('Description:'),
                  subtitle: Text(desc),
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}