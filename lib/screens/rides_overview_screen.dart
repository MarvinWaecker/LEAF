import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  static final String id = 'activity_screen';

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final Map<int, Widget> logoWidgets = const <int, Widget>{
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
  final Map<int, Widget> icons = const <int, Widget>{
    0: Center(
      child: FlutterLogo(
        colors: Colors.indigo,
        size: 220.0,
      ),
    ),
    1: Center(
      child: FlutterLogo(
        colors: Colors.teal,
        size: 200.0,
      ),
    ),
  };
  int sharedValue = 0;

  // Angeboten = true, Gebucht = false
  var isSelected = [false, true];

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
                children: logoWidgets,
                onValueChanged: (int val) {
                  setState(() {
                    sharedValue = val;
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
          /*
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
          ),
          */
        ],
      ),
    );
  }
}
