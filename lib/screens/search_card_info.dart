import 'package:flutter/material.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/screens/search_results_screen.dart';
import 'package:leaf/screens/seat_selection_screen.dart';
import 'package:leaf/services/database_service.dart';

class SearchCardInfo extends StatefulWidget {
  final int num;
  final Ride ride;
  final String name;
  final String car;
  final String bio;
  final String mood;
  final String music;
  final String smoke;
  final String pet;

  const SearchCardInfo(
      {Key key,
      this.num,
      this.ride,
      this.name,
      this.car,
      this.bio,
      this.music,
      this.mood,
      this.smoke,
      this.pet})
      : super(key: key);

  @override
  _SearchCardInfoState createState() => _SearchCardInfoState();
}

class _SearchCardInfoState extends State<SearchCardInfo> {

  _submit() async {
    DatabaseService.updateRide(widget.ride, context);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

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
                widget.name + 's Fahrt',
                style: TextStyle(
                  fontFamily: 'UbuntuRegular',
                  fontSize: 22,
                  color: Color(0xffE6EFE9),
                ),
              ),
            )),
        leading: Hero(
          tag: 'animateIcon',
          child: Material(
            color: Color(0xff111e2e),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Color(0xffe8b641),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: new BouncingScrollPhysics(),
            child: Column(children: <Widget>[
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
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    /// Start Ziel -----------------------------------------
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Material(
                                          color: Color(0xff192C43),
                                          child: Text(
                                            'Von ' + 'München',
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
                                            'nach ' + 'Tuttlingen',
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
                                          Padding(
                                            padding: EdgeInsets.only(right: 0),
                                            child: Container(
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
                                                      '13:30',
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
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 0),
                                            child: Container(
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
                                                    color: Color(0xff192C43),
                                                    child: Text(
                                                      'Fahrtdauer',
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
                                                      '1,5',
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
                                                    '7',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            blurRadius:
                                                3.0, // soften the shadow
                                            spreadRadius:
                                                2.0, //extend the shadow
                                            offset: Offset(
                                              2.5, // Move to right 10  horizontally
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
                                                  'Paul',
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
                                    onTap: () async {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(3.0),
                                            topLeft: Radius.circular(3.0)),
                                        color: Color(0xff213A59),
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
              Material(
                color: Color(0xff111e2e),
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Color(0xff213A59),
                      // Schatten???
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                            color: Color(0xff213A59),
                            child: Text(
                              'Auto',
                              style: TextStyle(
                                fontFamily: 'UbuntuLight',
                                fontSize: 16,
                                color: Color(0xffE6EFE9),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                            width: double.maxFinite,
                          ),
                          Material(
                            color: Color(0xff213A59),
                            child: Text(
                              widget.car,
                              style: TextStyle(
                                fontFamily: 'UbuntuLight',
                                fontSize: 14,
                                color: Color(0xffE6EFE9),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: double.maxFinite,
                          ),
                          Material(
                            color: Color(0xff213A59),
                            child: Text(
                              'Info',
                              style: TextStyle(
                                fontFamily: 'UbuntuLight',
                                fontSize: 16,
                                color: Color(0xffE6EFE9),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                            width: double.maxFinite,
                          ),
                          Material(
                            color: Color(0xff213A59),
                            child: Text(
                              'Fährt die Strecke regelmäßig\nStudent der HFU\n' +
                                  widget.mood +
                                  '\n' +
                                  widget.smoke +
                                  '\n' +
                                  widget.pet,
                              style: TextStyle(
                                fontFamily: 'UbuntuLight',
                                fontSize: 14,
                                color: Color(0xffE6EFE9),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: double.maxFinite,
                          ),
                          Material(
                            color: Color(0xff213A59),
                            child: Text(
                              'Bezahlung',
                              style: TextStyle(
                                fontFamily: 'UbuntuLight',
                                fontSize: 16,
                                color: Color(0xffE6EFE9),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                            width: double.maxFinite,
                          ),
                          Material(
                            color: Color(0xff213A59),
                            child: Text(
                              'PayPal',
                              style: TextStyle(
                                fontFamily: 'UbuntuLight',
                                fontSize: 14,
                                color: Color(0xffE6EFE9),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: double.maxFinite,
                          ),
                          Material(
                            color: Color(0xff213A59),
                            child: Text(
                              'Verfügbare Plätze',
                              style: TextStyle(
                                fontFamily: 'UbuntuLight',
                                fontSize: 16,
                                color: Color(0xffE6EFE9),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                            width: double.maxFinite,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Flexible(
                                child: GestureDetector(
                                  onTap: () async {
                                    await Future.delayed(
                                        Duration(milliseconds: 200));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return SeatSelectionScreen();
                                        },
                                        fullscreenDialog: true,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Hero(
                                      tag: 'animateCar',
                                      child: Image.asset(
                                          'assets/images/Sitzwahl_Auto_Draufsicht.png'),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 52,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 26, right: 8, left: 32),
                    child: SizedBox(
                      child: RaisedButton(
                        onPressed: () async {
                          await Future.delayed(Duration(milliseconds: 200));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SeatSelectionScreen();
                              },
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        color: Color(0xff213A59),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xff0cce6b)),
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        child: Text(
                          'SITZPLATZWAHL',
                          style: TextStyle(
                            color: Color(0xff0cce6b),
                            fontSize: 14,
                            fontFamily: 'UbuntuMedium',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 26, left: 8, right: 32),
                    child: SizedBox(
                      child: RaisedButton(
                        onPressed: _submit,
                        color: Color(0xff0cce6b),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        child: Text(
                          'FAHRT BUCHEN',
                          style: TextStyle(
                            color: Color(0xff111e2e),
                            fontSize: 14,
                            fontFamily: 'UbuntuMedium',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}