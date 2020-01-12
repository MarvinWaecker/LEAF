import 'package:flutter/material.dart';
import 'package:leaf/screens/search_screen.dart';
import 'package:leaf/screens/search_time_screen.dart';
import 'package:provider/provider.dart';
import 'package:leaf/screens/search_pages.dart';


class SearchLocationScreen extends StatefulWidget {
  PageController controllerS;
  int selectedIndex = 0;

  SearchLocationScreen({Key key, @required this.controllerS, this.selectedIndex}) : super(key: key);

  @override
  _SearchLocationScreenState createState() => _SearchLocationScreenState(NewControllerS: controllerS, NewSelectedIndex: selectedIndex,);
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  PageController NewControllerS;
  int NewSelectedIndex = 0;

  _SearchLocationScreenState({Key key, @required this.NewControllerS, this.NewSelectedIndex});

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
      body: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.bottomRight,
        child: RaisedButton(
          onPressed: () {

            onItemTapped(1);
          },
          color: Color(0xff0cce6b),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
          child: Text(
            'Start/Ziel',
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


