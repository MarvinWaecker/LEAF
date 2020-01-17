import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf/screens/home_screen.dart';
import 'dart:async';
import 'package:leaf/screens/mainBar_screen.dart';
import 'package:leaf/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:leaf/models/user_data.dart';

int check;

class SplashScreen extends StatefulWidget {



  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Variables

  @override
  void initState() {
    super.initState();

    Widget hallo = _getScreenId();

    if (check == 1) {
      Timer(Duration(milliseconds: 1500), () =>
          Navigator.of(context).push(
              new CupertinoPageRoute(builder: (context) => hallo)),
      );
    }
    else {
      Timer(Duration(milliseconds: 1500), () =>
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => hallo)),
      );
    }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: Text(
                  'LEAF',
                  style: TextStyle(
                    fontFamily: 'UbuntuLight',
                    fontSize: 113,
                    color: Color(0xffE6EFE9),
                  ),
                ),
              ),
            Container(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset (0,0),
                child: Text(
                  'your static life.',
                  style: TextStyle(
                    fontFamily: 'UbuntuLight',
                    fontSize: 40,
                    color: Color(0xffE6EFE9),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 55.0),
              child: MyStatefulWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animiertes Logo
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.6, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Hero(
          tag: 'startLogo',
          child: Image.asset(
            'assets/images/LEAF_Logo_mehr_Abstand.png',
            //scale: 0.5,
          ),
        ),
      ),
    );
  }
}


/// Navigation zu Login oder HomeScreen
Widget _getScreenId()
{
  return StreamBuilder<FirebaseUser>(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData) {
        Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
        check = 1;
        return MainBarScreen(0);
        // HomeScreen
      } else {
        check = 2;
        return LoginScreen();
        // LoginScreen
      }
    },
  );
}



