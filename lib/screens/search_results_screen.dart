import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/screens/search_card_info.dart';
import 'package:leaf/services/database_service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


String url = 'https://jsonplaceholder.typicode.com/posts';

// Variablen
String name = 'Paul';
String car = 'Golf';
String bio = 'Bio';
String music = 'Rap';
String mood = 'Ich liebe es zu quatschen';
String smoke = 'Nichtraucher';
String pet = 'Sorry, ich nehme keine Haustiere mit';


class SearchResultsScreen extends StatefulWidget {
  final String origin, destination, time, date, price;
  SearchResultsScreen(this.origin, this.destination, this.time, this.date, this.price);

  static final String id = 'search_results_screen';

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}


class _SearchResultsScreenState extends State<SearchResultsScreen> {

  /*
  void initState()
  {
    super.initState();

    getUserData(ride.creatorId, 'name', name)
  }

   */

  // Variables
  //TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final String origin = ModalRoute.of(context).settings.arguments.toString();
    final String origin = widget.origin;
    final String destination = widget.destination;
    final String time = widget.time;
    String date = widget.date;
    final String price = widget.price;


    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff111e2e),
        automaticallyImplyLeading: true,
        title: Hero(
          tag: 'animateText',
          child: Material(
            color: Color(0xff111e2e),
            child: Text(
              'Angebotene Fahrten',
              style: TextStyle(
                fontFamily: 'UbuntuRegular',
                fontSize: 22,
                color: Color(0xffE6EFE9),
              ),
            ),
          ),
        ),
        leading: Hero(
          tag: 'animateIcon',
          child: Material(
            color: Color(0xff111e2e),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffe8b641),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: DatabaseService.searchRides(origin, destination, date, time),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xff192C43),
                valueColor: AlwaysStoppedAnimation(
                  Color(0xff213a59),
                ),
              ),
            );
          }
          if (snapshot.data.documents.length == 0) {
            return Center(
              child: Text(
                'Uppss...\n'
                'Leider wurden keine passenden Fahrten gefunden.\n'
                'Schau doch später noch mal vorbei.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'UbuntuLight',
                  fontSize: 14,
                  color: Color(0xffE6EFE9),
                  height: 1.6,
                ),
              ),
            );
          }
          return ListView.builder(
            physics: new BouncingScrollPhysics(),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              Ride ride = Ride.fromDoc(snapshot.data.documents[index]);

              return SearchCardItem(num: index, ride: ride);
            },
          );
        },
      ),
    );
  }
}

class SearchCardItem extends StatelessWidget {

  final int num;
  final Ride ride;

  const SearchCardItem({Key key, this.num, this.ride}) : super(key: key);

  getData(String creatorId) async{
    return await Firestore.instance.
    collection(creatorId).getDocuments();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Hero(
          tag: 'card$num',
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
                                                'assets/images/thin_hourglass.png'),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Material(
                                            color:
                                            Color(0xff192C43),
                                            child: Text(
                                              'Datum',
                                              style: TextStyle(
                                                fontFamily:
                                                'UbuntuLight',
                                                fontSize: 12,
                                                color: Color(
                                                    0xffE6EFE9),
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color:
                                            Color(0xff192C43),
                                            child: Text(
                                              ride.date.substring(0, 5),
                                              style: TextStyle(
                                                fontFamily:
                                                'UbuntuLight',
                                                fontSize: 16,
                                                color: Color(
                                                    0xffE6EFE9),
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
                                            color:
                                            Color(0xff192C43),
                                            child: Text(
                                              'Abfahrt',
                                              style: TextStyle(
                                                fontFamily:
                                                'UbuntuLight',
                                                fontSize: 12,
                                                color: Color(
                                                    0xffE6EFE9),
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color:
                                            Color(0xff192C43),
                                            child: Text(
                                              ride.time,
                                              style: TextStyle(
                                                fontFamily:
                                                'UbuntuLight',
                                                fontSize: 16,
                                                color: Color(
                                                    0xffE6EFE9),
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
                                                fontFamily:
                                                'UbuntuLight',
                                                fontSize: 12,
                                                color:
                                                Color(0xffE6EFE9),
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: Color(0xff192C43),
                                            child: Text(
                                              ride.price,
                                              style: TextStyle(
                                                fontFamily:
                                                'UbuntuLight',
                                                fontSize: 16,
                                                color:
                                                Color(0xffE6EFE9),
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
                              onTap: () async {
                              },
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
                                          child: Text(name,
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
                                            backgroundImage: AssetImage(
                                                'assets/images/Profilbild_Paul.png'),
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
                            GestureDetector(
                              onTap: () async {
                                await Future.delayed(
                                    Duration(milliseconds: 200));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return new SearchCardInfo(
                                        num: num, ride: ride
                                      );
                                    },
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                              child: Container(
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
      ],
    );
  }
}

