import 'package:flutter/material.dart';

class SearchCardInfo extends StatefulWidget {
  final int count;
  final String origin, destination;
  SearchCardInfo(this.count, this.origin, this.destination);

  static final String id = 'search_results_screen';

  @override
  _SearchCardInfoState createState() => _SearchCardInfoState();
}

class _SearchCardInfoState extends State<SearchCardInfo> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'card$widget.count',
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0, // soften the shadow
                spreadRadius: 2.0, //extend the shadow
                offset: Offset(
                  0, // Move to right 10  horizontally
                  2.5, // Move to bottom 5 Vertically
                ),
              )
            ],
            borderRadius: BorderRadius.circular(5.0),
            color: Color(0xff192C43),
          ),
          child: SizedBox(
            height: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /// Start Ziel -----------------------------------------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Von ' + widget.origin,
                                style: TextStyle(
                                  fontFamily: 'UbuntuLight',
                                  fontSize: 20,
                                  color: Color(0xffE6EFE9),
                                ),
                              ),
                              Text(
                                'nach ' + widget.destination,
                                style: TextStyle(
                                  fontFamily: 'UbuntuLight',
                                  fontSize: 20,
                                  color: Color(0xffE6EFE9),
                                ),
                              ),
                            ],
                          ),

                          /// Drei Icons -----------------------------------------
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 0),
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 22,
                                          child: Image.asset('assets/images/thin_clock.png'),
                                        ),
                                        SizedBox(height: 4,),
                                        Text(
                                          'Abfahrt',
                                          style: TextStyle(
                                            fontFamily: 'UbuntuLight',
                                            fontSize: 12,
                                            color: Color(0xffE6EFE9),
                                          ),
                                        ),
                                        Text(
                                          '13:30',
                                          style: TextStyle(
                                            fontFamily: 'UbuntuLight',
                                            fontSize: 16,
                                            color: Color(0xffE6EFE9),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 0),
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 22,
                                          child: Image.asset('assets/images/thin_hourglass.png'),
                                        ),
                                        SizedBox(height: 4,),
                                        Text(
                                          'Fahrtdauer',
                                          style: TextStyle(
                                            fontFamily: 'UbuntuLight',
                                            fontSize: 12,
                                            color: Color(0xffE6EFE9),
                                          ),
                                        ),
                                        Text(
                                          '1,5',
                                          style: TextStyle(
                                            fontFamily: 'UbuntuLight',
                                            fontSize: 16,
                                            color: Color(0xffE6EFE9),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 22,
                                        child: Image.asset('assets/images/thin_euro.png'),
                                      ),
                                      SizedBox(height: 4,),
                                      Text(
                                        'Preis',
                                        style: TextStyle(
                                          fontFamily: 'UbuntuLight',
                                          fontSize: 12,
                                          color: Color(0xffE6EFE9),
                                        ),
                                      ),
                                      Text(
                                        '7',
                                        style: TextStyle(
                                          fontFamily: 'UbuntuLight',
                                          fontSize: 16,
                                          color: Color(0xffE6EFE9),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                /// Flaggen ------------------------------------------------------
                Padding(
                  padding:
                  EdgeInsets.only(right: 16, left: 32),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        /// Flagge oben ------------------------------------------
                        GestureDetector(
                          onTap: () {
                            /*
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SearchCardInfo(count),),);

                             */
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(3.0), bottomLeft: Radius.circular(3.0)),
                              color: Color(0xff294970),
                              boxShadow: [BoxShadow(
                                color: Colors.black12,
                                blurRadius: 3.0, // soften the shadow
                                spreadRadius: 2.0, //extend the shadow
                                offset: Offset(
                                  2.5, // Move to right 10  horizontally
                                  2.5, // Move to bottom 5 Vertically
                                ),
                              )],
                            ),
                            height: 76,
                            width: 57,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Text('Paul',
                                      style: TextStyle(
                                        fontFamily: 'UbuntuLight',
                                        fontSize: 12,
                                        color: Color(0xff0cce6b),
                                      ),
                                    ),
                                    Container(
                                      child: CircleAvatar(
                                        radius: 21.0,
                                        backgroundImage: AssetImage('assets/images/Profilbild_Paul.png'),
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16, width: 57,),
                        /// Flagge unten -----------------------------------------
                        GestureDetector(
                          onTap: () async {
                            /*
                            setState(() {
                              if (tapRec == false) {
                                flexHeight = 300;
                                tapRec = true;
                              } else {
                                flexHeight = 168;
                                tapRec = false;
                              }
                              ;
                            });
                             */
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(3.0), topLeft: Radius.circular(3.0)),
                              color: Color(0xff294970),
                              boxShadow: [BoxShadow(
                                color: Colors.black12,
                                blurRadius: 3.0, // soften the shadow
                                spreadRadius: 2.0, //extend the shadow
                                offset: Offset(
                                  2.5, // Move to right 10  horizontally
                                  0, // Move to bottom 5 Vertically
                                ),
                              )],
                            ),
                            height: 76,
                            width: 57,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5, left: 5, bottom: 15),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: ButtonTheme(
                                  child:
                                  Image.asset(
                                    'assets/images/Fahrtinfo_Leaf.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
