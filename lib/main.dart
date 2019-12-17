import 'package:flutter/material.dart';
import 'package:leaf/screens/activity_screen.dart';
import 'package:leaf/screens/feed_screen.dart';
import 'package:leaf/screens/home_screen.dart';
import 'package:leaf/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'models/user_data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return HomeScreen(
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        title: 'LEAF',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
                color: Colors.black,
              ),
          cursorColor: Colors.green,
        ),
        home: _getScreenId(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          FeedScreen.id: (context) => FeedScreen(),
          ActivityScreen.id: (context) => ActivityScreen(),
        },
      ),
    );
  }
}
