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
      padding: EdgeInsets.all(10),
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
                leading: Icon(ic, size: 45),
                title: Text(maintitle),
                subtitle: Text(subtitle),
                trailing: CircleAvatar(
                  backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2017/11/06/13/45/cap-2923682_960_720.jpg'),
                  radius: 28,
                ),
              ),
              Container(
                child: Image.network('https://cdn.pixabay.com/photo/2017/03/20/15/13/wrist-watch-2159351_960_720.jpg', fit: BoxFit.fill),
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