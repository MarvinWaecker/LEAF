import 'package:flutter/material.dart';
import 'package:leaf/services/auth_service.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
  static final String id = 'feed_screen';
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(child:
        FlatButton(onPressed: () => AuthService.logout(context),
        child: Text('LOGOUT')
          ),
        ),
    );
  }
}
