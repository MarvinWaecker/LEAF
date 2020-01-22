import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/screens/overview_card_info.dart';
import 'dart:async';

class OverviewCardItem extends StatelessWidget {
  final int num;
  final Ride ride;
  final User user;

  const OverviewCardItem({Key key, this.num, this.ride, this.user})
      : super(key: key);

  getData(String creatorId) async {
    return await Firestore.instance.collection(creatorId).getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Hero(
          tag: 'overviewCard$num',
          flightShuttleBuilder: (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
          ) {
            return SingleChildScrollView(
              child: fromHeroContext.widget,
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () async {
                await Future.delayed(Duration(milliseconds: 200));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return new OverviewCardInfo(num: num, ride: ride);
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
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
                  height: 168,
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
                                    Material(
                                      color: Color(0xff192C43),
                                      child: Text(
                                        'Von ' + ride.origin,
                                        style: TextStyle(
                                          fontFamily: 'UbuntuLight',
                                          fontSize: 20,
                                          color: Color(0xffE6EFE9),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: Color(0xff192C43),
                                      child: Text(
                                        'nach ' + ride.destination,
                                        style: TextStyle(
                                          fontFamily: 'UbuntuLight',
                                          fontSize: 20,
                                          color: Color(0xffE6EFE9),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                /// Drei Icons -----------------------------------------
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    //crossAxisAlignment: CrossAxisAlignment.,
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              height: 22,
                                              child: Image.asset(
                                                  'assets/images/thin_calendar.png'),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Material(
                                              color: Color(0xff192C43),
                                              child: Text(
                                                'Datum',
                                                style: TextStyle(
                                                  fontFamily: 'UbuntuLight',
                                                  fontSize: 12,
                                                  color: Color(0xffE6EFE9),
                                                ),
                                              ),
                                            ),
                                            Material(
                                              color: Color(0xff192C43),
                                              child: Text(
                                                ride.date.substring(0, 6),
                                                style: TextStyle(
                                                  fontFamily: 'UbuntuLight',
                                                  fontSize: 16,
                                                  color: Color(0xffE6EFE9),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              height: 22,
                                              child: Image.asset(
                                                  'assets/images/thin_clock.png'),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Material(
                                              color: Color(0xff192C43),
                                              child: Text(
                                                'Abfahrt',
                                                style: TextStyle(
                                                  fontFamily: 'UbuntuLight',
                                                  fontSize: 12,
                                                  color: Color(0xffE6EFE9),
                                                ),
                                              ),
                                            ),
                                            Material(
                                              color: Color(0xff192C43),
                                              child: Text(
                                                ride.time,
                                                style: TextStyle(
                                                  fontFamily: 'UbuntuLight',
                                                  fontSize: 16,
                                                  color: Color(0xffE6EFE9),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              height: 22,
                                              child: Image.asset(
                                                  'assets/images/thin_euro.png'),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Material(
                                              color: Color(0xff192C43),
                                              child: Text(
                                                'Preis',
                                                style: TextStyle(
                                                  fontFamily: 'UbuntuLight',
                                                  fontSize: 12,
                                                  color: Color(0xffE6EFE9),
                                                ),
                                              ),
                                            ),
                                            Material(
                                              color: Color(0xff192C43),
                                              child: Text(
                                                ride.price,
                                                style: TextStyle(
                                                  fontFamily: 'UbuntuLight',
                                                  fontSize: 16,
                                                  color: Color(0xffE6EFE9),
                                                ),
                                              ),
                                            ),
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
                        padding: EdgeInsets.only(right: 16, left: 32),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              /// Flagge oben ------------------------------------------
                              GestureDetector(
                                onTap: () async {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(3.0),
                                        bottomLeft: Radius.circular(3.0)),
                                    color: Color(0xff294970),
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
                                  ),
                                  height: 76,
                                  width: 57,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Material(
                                            color: Color(0xff294970),
                                            child: Text(
                                              user.name,
                                              style: TextStyle(
                                                fontFamily: 'UbuntuLight',
                                                fontSize: 12,
                                                color: Color(0xff0cce6b),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: CircleAvatar(
                                              radius: 21.0,
                                              backgroundImage: user
                                                      .profileImageUrl.isEmpty
                                                  ? AssetImage(
                                                      'assets/images/logo.png')
                                                  : CachedNetworkImageProvider(
                                                      user.profileImageUrl),
                                              backgroundColor: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                                width: 57,
                              ),

                              /// Flagge unten -----------------------------------------
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(3.0),
                                      topLeft: Radius.circular(3.0)),
                                  color: Color(0xff294970),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4.0, // soften the shadow
                                      spreadRadius: 2.0, //extend the shadow
                                      offset: Offset(
                                        0, // Move to right 10  horizontally
                                        0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                height: 76,
                                width: 57,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 5, left: 5, bottom: 18),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: ButtonTheme(
                                      child: Image.asset(
                                        'assets/images/Fahrtinfo_Leaf.png',
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
          ),
        ),
      ],
    );
  }
}
