import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rucksack/color/colors.dart';
import 'package:rucksack/mywidget/homecard.dart';
import 'package:rucksack/mywidget/myiconbutton/myiconbutton.dart';
import 'package:rucksack/screens/homescreen.dart';


var todelstr =
    'While it may not be obvious to everyone, there are a number of reasons creating random paragraphs can be useful.'
    ' A few examples of how some people use this generator are listed in the following paragraphs.';

class AfterOpen extends StatefulWidget {
  var out_tags;
  var out_longdesc;
  var out_util;
  var out_condition;
  var out_userid;
  List<String> out_imgs = [];

  //const AfterOpen({Key? key}) : super(key: key);
  // {
  //   /*{this.selectedItem}*/
  //   // print('\n\n\n this is what we are doing\n\n\n');
  //   // print(this.selectedItem);
  //   // allimgs = selectedItem!['item_image'];
  // }
  AfterOpen(this.out_longdesc, this.out_tags, this.out_condition, this.out_util, this.out_userid, this.out_imgs ){

  }
  static String id = 'afterOpen';

  @override
  State<AfterOpen> createState() => _AfterOpenState();
}

class _AfterOpenState extends State<AfterOpen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(height: 300.0,   enableInfiniteScroll: false,      autoPlay: false, aspectRatio: 23/9),
                  items: widget.out_imgs.map((i) {
                    print("\nwidget is here rio"+i+"\n");
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(

                            width: MediaQuery.of(context).size.width+80,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                            ),
                            child: Image(image: NetworkImage(i.toString()), fit: BoxFit.fill,),
                        );
                      },
                    );
                  }).toList(),
                ),


                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Color(0xff2C3333),
                    //color: Colors.white,
                  ),
                  margin: EdgeInsets.only(top: 230),
                  height: 600 - 114,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 20, bottom: 10),
                        child: Text(
                          'RuckSack ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'PressStart',
                            //backgroundColor: Colors.black54,
                            letterSpacing: 1.8,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          simpleIconButton(FontAwesomeIcons.solidHeart,
                              Colors.black54, Color(0xff69DADB), () {
                            print('this is the first name');
                          }, 17),
                          simpleIconButton(FontAwesomeIcons.shoppingBag,
                              Colors.black54, Color(0xff69DADB), () {
                            print('hello');
                          }, 17),
                          simpleIconButton(FontAwesomeIcons.phone,
                              Colors.black54, Color(0xff69DADB), () {
                            print('hello');
                          }, 17),
                          simpleIconButton(FontAwesomeIcons.paperclip,
                              Colors.black54, Color(0xff69DADB), () {
                            print('hello');
                          }, 17),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 18, top: 12, bottom: 8),
                              child: Text(
                                '🍃 Overview',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white54,
                                    letterSpacing: 1.3),
                              )),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 431,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          //myitemselected['description'].toString()
                          children: <Widget>[
                            RowTile(FontAwesomeIcons.database, 'DETAILED DESCRIPTION\n\n   '+widget.out_longdesc),
                            RowTile(FontAwesomeIcons.timeline, 'UTILITY\n\n   '+widget.out_util),
                            RowTile(FontAwesomeIcons.clock, 'USAGE/ CONDITION\n\n   '+widget.out_condition),
                            RowTile(FontAwesomeIcons.tags, 'TAGS\n\n   '+ widget.out_tags),
                            SizedBox(height: 80,),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class RowTile extends StatelessWidget {
  var reficon;
  var txt;
  RowTile(this.reficon, this.txt) {}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30, left: 16),
          child: CircleAvatar(
            child: Icon(
              reficon,
              size: 20,
              color: Colors.white54,
            ),
            radius: 30,
            backgroundColor: Color(0xff395B64),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 13, top: 20),
          width: MediaQuery.of(context).size.width - 110,
          child: Text(
            txt,
            style: TextStyle(
                fontFamily: 'Roboto', fontWeight: FontWeight.w200),
          ),
        ),
      ],
    );
  }
}
