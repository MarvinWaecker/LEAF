import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leaf/screens/search_results_screen.dart';

class SearchTimeScreen extends StatefulWidget {
  PageController controllerS;
  int selectedIndex = 0;

  SearchTimeScreen({Key key, @required this.controllerS, this.selectedIndex}) : super(key: key);

  @override
  _SearchTimeScreenState createState() => _SearchTimeScreenState(NewControllerS: controllerS, NewSelectedIndex: selectedIndex,);
}

class _SearchTimeScreenState extends State<SearchTimeScreen> {
  PageController NewControllerS;
  int NewSelectedIndex = 0;

  _SearchTimeScreenState({Key key, @required this.NewControllerS, this.NewSelectedIndex});

  void onItemTapped(int index) {
    setState(() {
      NewSelectedIndex = index;
    });
    NewControllerS.animateToPage(NewSelectedIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff111e2e),
          automaticallyImplyLeading: true,
          title: Text(
            'Date/Time',
            style: TextStyle(
              fontFamily: 'UbuntuRegular',
              fontSize: 24,
              color: Color(0xffE6EFE9),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.navigate_before,
              color: Color(0xffe8b641),
            ),
            onPressed: () {
              onItemTapped(0);
            },
          )),
      body: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.bottomRight,
        child: RaisedButton(
          onPressed: () {

            print('Läuft');
          },
          color: Color(0xff0cce6b),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
          child: Text(
            'WEITER',
            style: TextStyle(
              color: Color(0xff111e2e),
              fontSize: 14,
              fontFamily: 'UbuntuMedium',
            ),
          ),
        ),
      ),

    );
  }
}
