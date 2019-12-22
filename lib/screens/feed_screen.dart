import 'package:flutter/material.dart';
import 'package:leaf/screens/home_screen.dart';
import 'package:leaf/screens/search_screen.dart';
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'LEAF',
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 35.0,
            fontFamily: 'Raleway',
          ),
        ),
      ),
      //backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: ((MediaQuery.of(context).size.height) / 2) - 78,
                    child: FlatButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SearchScreen())),
                      color: Color.fromARGB(200, 232, 182, 65),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Suche',
                        style: TextStyle(
                          color: Color.fromARGB(255, 12, 206, 107),
                          fontSize: 80.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: ((MediaQuery.of(context).size.height) / 2) - 78,
                    child: FlatButton(
                      onPressed: () => print('Biete'),
                      color: Color.fromARGB(200, 12, 206, 107),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Biete',
                        style: TextStyle(
                          color: Color.fromARGB(255, 232, 182, 65),
                          fontSize: 80.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
