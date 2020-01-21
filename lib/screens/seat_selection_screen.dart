import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leaf/animations/page_transition1.dart';
import 'package:leaf/animations/page_transition2.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/screens/booked_screen.dart';
import 'package:leaf/screens/rides_overview_screen.dart';
import 'package:leaf/screens/mainBar_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final User user;

  SeatSelectionScreen(this.user);

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen>
    with SingleTickerProviderStateMixin {

  // Variables
  GlobalKey _keyCar = GlobalKey();
  Duration _animationDuration = Duration(milliseconds: 200);
  bool _visible = false;
  bool _position = false;
  bool _radius = false;
  bool _bottom = false;
  bool _right = false;
  double sizeCarHeight = 0;
  double sizeCarWidth = 0;
  double width100 = 0;
  double height100 = 0;
  double fadePositionBottom = 0;
  double fadePositionRight = 0;
  double finalPositionBottom = 0;
  double finalPositionRight = 0;


  _getSizes() {
    final RenderBox renderBoxCar = _keyCar.currentContext.findRenderObject();
    sizeCarWidth = renderBoxCar.size.width;
    sizeCarHeight = renderBoxCar.size.height;
    print("Width of Car: $sizeCarWidth");
    print("Height of Car: $sizeCarHeight");

    width100 = MediaQuery.of(context).size.width;
    height100 = MediaQuery.of(context).size.height;

    double factorHeight = 0.39178467028586605;
    double factorWidth = 0.22327044025157233;

    fadePositionBottom = sizeCarHeight*factorHeight;
    finalPositionRight = sizeCarWidth*factorWidth;

    finalPositionBottom = fadePositionBottom-20;
    fadePositionRight = finalPositionRight-20;

    print("test" + sizeCarHeight.toString());
    print("test0" + factorWidth.toString());
    print("test: " + finalPositionBottom.toString());
    print("test2: " + fadePositionBottom.toString());
  }


  @override
  Widget build(BuildContext context) {
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
              'Sitzplatzwahl',
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
                Icons.close,
                color: Color(0xffe8b641),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Material(
        color: Color(0xff111e2e),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff192C43),
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
                height: double.maxFinite,
                child: SingleChildScrollView(
                  physics: new NeverScrollableScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height-10,
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 16),
                                  child: Stack(
                                    children: <Widget>[
                                      Hero(
                                        tag: 'animateCar',
                                        child: Image.asset(
                                            'assets/images/Auto_Draufsicht_GMD.png'),
                                        key: _keyCar,
                                      ),
                                      AnimatedPositioned(
                                        bottom: _bottom ? 250 : 230,
                                        right: _right ? 70 : 50,
                                        duration: _animationDuration,
                                        child: AnimatedOpacity(
                                          opacity: _visible ? 1.0 : 0.0,
                                          duration: _animationDuration,
                                          child: Container(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _position = !_position;
                                                  _visible = !_visible;
                                                  _radius = !_radius;
                                                  _bottom = !_bottom;
                                                  _right = !_right;
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: _radius ? 30.0 : 50.0,
                                                backgroundImage: widget.user.profileImageUrl.isEmpty
                                                    ? AssetImage('assets/images/logo.png')
                                                    : CachedNetworkImageProvider(
                                                    widget.user.profileImageUrl),
                                                backgroundColor: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              height: 170,
                              color: Colors.transparent,
                              child: Stack(
                                children: <Widget>[
                                  AnimatedPositioned(
                                    curve: Curves.easeIn,
                                    duration: _animationDuration,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width - 32,
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 16, right: 8),
                                              child: SizedBox(
                                                child: RaisedButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  color: Color(0xff192C43),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Color(0xff0cce6b)),
                                                    borderRadius:
                                                    new BorderRadius.circular(
                                                        18.0),
                                                  ),
                                                  child: Text(
                                                    'BESTÄTIGEN &\nZUR ÜBERSICHT',
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
                                              padding: EdgeInsets.only(left: 8, right: 16),
                                              child: SizedBox(
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context, EnterExitRoute(exitPage: SeatSelectionScreen(widget.user), enterPage: BookedScreen()));
                                                  },
                                                  color: Color(0xff0cce6b),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    new BorderRadius.circular(
                                                        18.0),
                                                  ),
                                                  child: Text(
                                                    'BESTÄTIGEN &\nFAHRT BUCHEN',
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
                                    top: _position ? 10 : 90,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


