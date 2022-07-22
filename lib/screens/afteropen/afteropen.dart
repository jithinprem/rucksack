import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rucksack/color/colors.dart';
import 'package:rucksack/mywidget/myiconbutton/myiconbutton.dart';

var todelstr =
    'While it may not be obvious to everyone, there are a number of reasons creating random paragraphs can be useful.'
    ' A few examples of how some people use this generator are listed in the following paragraphs.';

class AfterOpen extends StatefulWidget {
  const AfterOpen({Key? key}) : super(key: key);
  static String id = 'afteropen';

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
                Container(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2022/07/08/06/53/chateau-7308612__340.jpg'),
                    fit: BoxFit.fill,
                  ),
                  height: 280,
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
                            print('hello');
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
                          children: <Widget>[
                            RowTile(FontAwesomeIcons.database, 'DETAILED DESCRIPTION\n\n   '+todelstr),
                            RowTile(FontAwesomeIcons.timeline, 'UTILITY\n\n   '+todelstr),
                            RowTile(FontAwesomeIcons.clock, 'USAGE/ CONDITION\n\n   '+todelstr),
                            RowTile(FontAwesomeIcons.tags, 'TAGS\n\n   '+ 'phone, android, awesome, youtube, camera'),
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
