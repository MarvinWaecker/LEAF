import 'package:flutter/material.dart';
import 'package:leaf/animations/page_transition1.dart';
import 'package:leaf/screens/activity_screen.dart';
import 'package:leaf/screens/mainBar_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
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

  _getSizes() {
    final RenderBox renderBoxCar = _keyCar.currentContext.findRenderObject();
    final sizeCar = renderBoxCar.size;
    sizeCarWidth = renderBoxCar.size.width;
    sizeCarHeight = renderBoxCar.size.height;
    print("Width of Car: $sizeCarWidth");
    print("Height of Car: $sizeCarHeight");
  }


  @override
  Widget build(BuildContext context) {

    _getSizes();
    // Variables
    double width100 = MediaQuery.of(context).size.width;
    double height100 = MediaQuery.of(context).size.height;

    final double positionBottom = 240;
    final double positionRight = 71;

    double factorHeight = positionBottom/sizeCarHeight;
    double factorWidth = positionRight/sizeCarWidth;

    double fadePositionBottom = sizeCarHeight*factorHeight;
    double finalPositionRight = sizeCarWidth*factorWidth;

    double finalPositionBottom = fadePositionBottom-20;
    double fadePositionRight = finalPositionRight-20;

    print("test" + sizeCarHeight.toString());
    print("test0" + factorHeight.toString());
    print("test: " + finalPositionBottom.toString());
    print("test2: " + fadePositionBottom.toString());

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
                    height: height100,
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
                                  padding: EdgeInsets.only(
                                      top: 32, left: 32, right: 32, bottom: 16),
                                  child: Stack(
                                    children: <Widget>[
                                      Hero(
                                        tag: 'animateCar',
                                        child: Image.asset(
                                            'assets/images/Sitzwahl_Auto_Draufsicht.png'),
                                        key: _keyCar,
                                      ),
                                      AnimatedPositioned(
                                        bottom: _bottom ? finalPositionBottom : fadePositionBottom,
                                        right: _right ? finalPositionRight : fadePositionRight,
                                        duration: _animationDuration,
                                        child: AnimatedOpacity(
                                          opacity: _visible ? 1.0 : 1.0,
                                          duration: _animationDuration,
                                          child: Container(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _getSizes();
                                                  _position = !_position;
                                                  _visible = !_visible;
                                                  _radius = !_radius;
                                                  _bottom = !_bottom;
                                                  _right = !_right;
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: _radius ? 30.0 : 50.0,
                                                backgroundImage: AssetImage(
                                                    'assets/images/Profilbild_Paul.png'),
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
                                      width: width100 - 32,
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
                                                  color: Color(0xff213A59),
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
                                                        context, ScaleRoute(page: MainBarScreen(3)));
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


