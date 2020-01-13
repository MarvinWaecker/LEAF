import 'package:flutter/material.dart';


class SearchCardInfo extends StatefulWidget {

  static final String id = 'search_results_screen';

  @override
  _SearchCardInfoState createState() => _SearchCardInfoState();
}

class _SearchCardInfoState extends State<SearchCardInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff111e2e),
          automaticallyImplyLeading: true,
          title: Text(
            'Fahrten für den 18.01.2020',
            style: TextStyle(
              fontFamily: 'UbuntuRegular',
              fontSize: 22,
              color: Color(0xffE6EFE9),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.navigate_before,
              color: Color(0xffe8b641),
            ),
            onPressed: () => Navigator.pop(context),
          )
      ),
      body: Center(
        child: Hero(
          tag: 'startZiel',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Von München',
                style: TextStyle(
                  fontFamily: 'UbuntuLight',
                  fontSize: 20,
                  color: Color(0xffE6EFE9),
                ),
              ),
              Text(
                'nach Tuttlingen',
                style: TextStyle(
                  fontFamily: 'UbuntuLight',
                  fontSize: 20,
                  color: Color(0xffE6EFE9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}