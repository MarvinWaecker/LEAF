
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/screens/search_results_screen.dart';
import 'package:leaf/services/database_service.dart';

class RidesOverviewScreen extends StatefulWidget {
  static final String id = 'activity_screen';

  @override
  _RidesOverviewScreenState createState() => _RidesOverviewScreenState();
}

class _RidesOverviewScreenState extends State<RidesOverviewScreen> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  final Map<int, Widget> segmentOptions = const <int, Widget>{
    0: Text(
      'Gebucht',
      style: TextStyle(
        fontSize: 16.0,
        fontFamily: 'UbuntuLight',
      ),
    ),
    1: Text(
      'Angeboten',
      style: TextStyle(
        fontSize: 16.0,
        fontFamily: 'UbuntuLight',
      ),
    ),
  };
  // 0 = Gebucht, 1 = Angeboten
  int sharedValue = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color(0xff111e2e),
        automaticallyImplyLeading: false,
        title: Text(
          'Fahrten',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'UbuntuLight',
            color: Color(0xffE6EFE9),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Container(
              width: 250,
              child: CupertinoSegmentedControl<int>(
                unselectedColor: Color(0xff111e2e),
                selectedColor: Color(0xff0cce6b),
                borderColor: Color(0xff0cce6b),
                pressedColor: Color(0xff213A59),
                children: segmentOptions,
                onValueChanged: (int val) {
                  setState(() {
                    sharedValue = val;
                    print("sharedValue" + sharedValue.toString());
                    print("val" + val.toString());
                  });
                },
                groupValue: sharedValue,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0, // soften the shadow
                    spreadRadius: 2.0, //extend the shadow
                    offset: Offset(
                      0, // Move to right 10  horizontally
                      4.0, // Move to bottom 5 Vertically
                    ),
                  ),
                ],
              ),
              width: double.infinity,
              child: DefaultTabController(
                length: 2,
                child: Container(
                  color: Color(0xff111e2e),
                  child: TabBar(
                    controller: _tabController,
                      labelColor: Color(0xffE6EFE9),
                      unselectedLabelColor: Color(0xffAAAEB2),
                      indicatorColor: Color(0xff0cce6b),
                      tabs: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8, top: 16),
                          child: Text(
                            'Zukünftig',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'UbuntuLight',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8, top: 16),
                          child: Text(
                            'Vergangen',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'UbuntuLight',
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: getTabView(context, sharedValue, _tabController),
            ),
          ),
        ],
      ),
    );
  }
}


Widget futureRidesBooked() {
  //return new Text("Zukünftige gebuchte Fahrten");
  FutureBuilder(
    future: DatabaseService.futureRidesBooked(),
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
            'Uppss..\n'
                'Leider wurden keine passenden Fahrten gefunden.\n'
                'Schau doch später noch mal vorbei.',
            style: TextStyle(
              fontFamily: 'UbuntuLight',
              fontSize: 14,
              color: Color(0xffE6EFE9),
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
  );
}

Widget pastRidesBooked(context) {
  //return new Text("Vergangene gebuchte Fahrten");
  FutureBuilder(
    future: DatabaseService.pastRidesBooked(context),
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
            'Uppss..\n'
                'Leider wurden keine passenden Fahrten gefunden.\n'
                'Schau doch später noch mal vorbei.',
            style: TextStyle(
              fontFamily: 'UbuntuLight',
              fontSize: 14,
              color: Color(0xffE6EFE9),
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
  );
}
Widget futureRidesCreated(context) {
  //return new Text("Zukünftige angebotene Fahrten");
  FutureBuilder(
    future: DatabaseService.futureRidesCreated(),
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
            'Uppss..\n'
                'Leider wurden keine passenden Fahrten gefunden.\n'
                'Schau doch später noch mal vorbei.',
            style: TextStyle(
              fontFamily: 'UbuntuLight',
              fontSize: 14,
              color: Color(0xffE6EFE9),
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
  );
}

Widget pastRidesCreated() {
  //return new Text("Vergangene angebotene Fahrten");
  FutureBuilder(
    future: DatabaseService.pastRidesCreated(),
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
            'Uppss..\n'
                'Leider wurden keine passenden Fahrten gefunden.\n'
                'Schau doch später noch mal vorbei.',
            style: TextStyle(
              fontFamily: 'UbuntuLight',
              fontSize: 14,
              color: Color(0xffE6EFE9),
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
  );
}

Widget getTabView(BuildContext context, int sharedValue, TabController _tabController) {

  if(sharedValue == 0) {
    return TabBarView(
      children: [
        // Future Builder aufrufen
        futureRidesBooked(),
        // Future Builder aufrufen
        pastRidesBooked(context),
      ],
      controller: _tabController,
    );
  }
  else {
    return TabBarView(
      children: [
        // Future Builder aufrufen
        futureRidesCreated(context),
        // Future Builder aufrufen
        pastRidesCreated(),
      ],
      controller: _tabController,
    );
  }
}

/*
Widget test () {
  FutureBuilder(
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
            'Uppss..\n'
                'Leider wurden keine passenden Fahrten gefunden.\n'
                'Schau doch später noch mal vorbei.',
            style: TextStyle(
              fontFamily: 'UbuntuLight',
              fontSize: 14,
              color: Color(0xffE6EFE9),
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
  );
}

 */

