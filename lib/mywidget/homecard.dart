import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rucksack/mywidget/myiconbutton/myiconbutton.dart';

//var greencol = Color(0xff446A46);
var greencol =  Color(0xff1ECE5C7);
//var greencol = Color(0xffE0DDAA);

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
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.blueGrey[900]
      ),
      width: double.infinity,
      child:  Card(
        child: InkWell(
          onTap: () {
            print("tapped");
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 70,
                child: ListTile(
                  tileColor: greencol,
                  leading: Icon(ic, size: 45, color: Colors.black54,),
                  title: Text(maintitle+'\n', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PressStart', fontSize: 10, color: Colors.black),),
                  subtitle: Text(subtitle, style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w900, fontSize: 11, color: Colors.black54),),
                  trailing: CircleAvatar(
                    backgroundImage: NetworkImage(profpic),
                    radius: 28,
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    child: Image.network(pic, fit: BoxFit.fill, height: 240, width: double.infinity,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 150),
                    height: 90,
                    width: double.infinity,
                    color: Colors.black54,
                    child: Row(
                      children: <Widget>[
                        simpleIconButton(FontAwesomeIcons.heart, Colors.white, Colors.transparent, (){print('hellohome');}),
                        simpleIconButton(FontAwesomeIcons.phone, Colors.white, Colors.transparent, (){print('hellohome');}),
                        Text('\n   Rucksack @', style: TextStyle(fontFamily: 'PressStart', fontSize: 9),),
                        Text('\n'+price, style: TextStyle(fontFamily: 'PressStart', fontSize: 15),),
                      ],
                    ),
                  )
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     Container(
              //       child: FaIcon(
              //         FontAwesomeIcons.solidHeart,
              //         size: 30,
              //       ),
              //     ),
              //     Container(
              //       child: CircleAvatar(
              //         child: Text('₹ '+price, style: TextStyle(fontSize: 10, color: Colors.white),),
              //         backgroundColor: Colors.amber,
              //       ),
              //     )
              //   ],
              // ),
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