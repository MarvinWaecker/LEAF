import 'package:flutter/material.dart';
import 'package:leaf/screens/search_time_screen.dart';

class SearchLocationScreen extends StatefulWidget {
  @override
  _SearchLocationScreenState createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      appBar: AppBar(
          backgroundColor: Color(0xff111e2e),
          automaticallyImplyLeading: true,
          title: Text(
            'Fahrt suchen',
            style: TextStyle(
              fontFamily: 'UbuntuRegular',
              fontSize: 24,
              color: Color(0xffE6EFE9),
            ),
          ),
          leading: IconButton(icon:Icon(Icons.arrow_back, color: Color(0xffe8b641),),
            onPressed:() => Navigator.pop(context, false),
          )
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 16, left: 16),
            alignment: Alignment.topLeft,
            child: Text(
              'Wohin willst du?',
              style: TextStyle(
                fontFamily: 'UbuntuLight',
                fontSize: 20,
                color: Color(0xffE6EFE9),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(
                color: Color(0xffE6EFE9),
                fontFamily: 'UbuntuRegular',
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                labelText: 'Start',
                labelStyle: TextStyle(
                    color: Color(0xff4171AB),
                    fontFamily: 'UbuntuRegular'
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff4171AB)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0cce6b)),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(
                color: Color(0xffE6EFE9),
                fontFamily: 'UbuntuRegular',
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                labelText: 'Ziel',
                labelStyle: TextStyle(
                    color: Color(0xff4171AB),
                    fontFamily: 'UbuntuRegular'
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff4171AB)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0cce6b)),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.bottomRight,
            child: RaisedButton(
              //onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SearchTimeScreen())),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchTimeScreen(
                  ),
                ),
              ),
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
        ],
      ),
    );
  }
}
