import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final Function toSearchScreen;
  final Function toCreateRideScreen;

  MainScreen({
    this.toSearchScreen,
    this.toCreateRideScreen,
  });

  @override
  _MainScreenState createState() => _MainScreenState();
  static final String id = 'main_screen';
}

class _MainScreenState extends State<MainScreen> {
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
                      onPressed: widget.toSearchScreen,
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
                      onPressed: widget.toCreateRideScreen,
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
