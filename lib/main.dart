import 'package:flutter/material.dart';
import 'package:leaf/screens/rides_overview_screen.dart';
import 'package:leaf/screens/home_screen.dart';
import 'package:leaf/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf/screens/search_results_screen.dart';
import 'package:leaf/screens/seat_selection_screen.dart';
import 'package:leaf/screens/signup_screen.dart';
import 'package:leaf/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'models/user_data.dart';
import 'package:flutter/services.dart';
import 'package:leaf/screens/test.dart';


void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    /// Status Bar und Navigation Bar - Farbe anpassen
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Color(0xff111e2e),
      systemNavigationBarColor: Color(0xff111e2e),
    ));



    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        title: 'LEAF',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          brightness: Brightness.dark,
          //primaryColor: Color(0xff0cce6b),
          accentColor: Color(0xff0cce6b),
          hintColor: Color(0xff4171AB),
          //buttonColor: Color(0xff0cce6b),
          //backgroundColor: Color(0xff111e2e),
          fontFamily: 'UbuntuRegular',
          cursorColor: Color(0xff0cce6b),
          //primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(color: Colors.black,),
        ),
        home: SplashScreen(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          RidesOverviewScreen.id: (context) => RidesOverviewScreen(),
          // Fehlen noch einige

          /// Befehl um von überall bestimmten Screen zu öffnen:
          // => Navigator.of(context).pushNamed("Hier steht der ScreenName, z.B. login_screen"),

        },
      ),
    );
  }
}





