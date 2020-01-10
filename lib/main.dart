import 'package:flutter/material.dart';
import 'package:leaf/screens/activity_screen.dart';
import 'package:leaf/screens/home_screen.dart';
import 'package:leaf/screens/mainBar_screen.dart';
import 'package:leaf/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf/screens/signup_screen.dart';
import 'package:leaf/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'models/user_data.dart';
import 'package:flutter/services.dart';


void main() => runApp(new MyApp());



class MyApp extends StatelessWidget {




  @override
  Widget build(BuildContext context) {


    // Status Bar und Navigation Bar - Farbe anpassen
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff111e2e),
      systemNavigationBarColor: Color(0xff111e2e),
    ));


    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        title: 'LEAF',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff0cce6b),
          accentColor: Color(0xff0cce6b),
          buttonColor: Color(0xff0cce6b),
          backgroundColor: Color(0xff111e2e),
          fontFamily: 'UbuntuRegular',
          cursorColor: Color(0xffE6EFE9),
          //primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(color: Colors.black,),
        ),
        home: SplashScreen(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          ActivityScreen.id: (context) => ActivityScreen(),
        },
      ),
    );
  }
}





