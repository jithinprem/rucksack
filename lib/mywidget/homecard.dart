import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeItemTile extends StatelessWidget {
  var maintitle;
  var subtitle;
  var pic;
  var profpic;
  var price;
  IconData ic;
  HomeItemTile(this.maintitle,this.subtitle,this.pic, this.profpic,this.price, this.ic){
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
              SizedBox(
                height: 8,
                child: Container(
                  color: Colors.blueGrey[900],
                ),
              ),
              Container(
                height: 70,
                child: ListTile(
                  tileColor: Colors.blueGrey[900],
                  leading: Icon(ic, size: 45),
                  title: Text(maintitle),
                  subtitle: Text(subtitle),
                  trailing: CircleAvatar(
                    backgroundImage: NetworkImage(profpic),
                    radius: 28,
                  ),
                ),
              ),
              Container(
                child: Image.network(pic, fit: BoxFit.fill, height: 240, width: double.infinity,),
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.solidHeart,
                      size: 30,
                    ),
                  ),
                  Container(
                    child: CircleAvatar(
                      child: Text('₹ '+price, style: TextStyle(fontSize: 10, color: Colors.white),),
                      backgroundColor: Colors.amber,
                    ),
                  )
                ],
              ),
              // Container(
              //   child: ListTile(
              //     title: Text('Description:'),
              //     subtitle: Text(price),
              //   ),
              // ),

            ],
          ),
        ),

      ),
    );
  }
}