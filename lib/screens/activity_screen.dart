import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  static final String id = 'activity_screen';

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  // Angeboten = true, Gebucht = false
  var isSelected = [false, true];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff111e2e),
        automaticallyImplyLeading: false,
        title: Text(
          'Übersicht',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'UbuntuRegular',
            color: Color(0xffE6EFE9),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Color(0xff0cce6b)),
            child: Container(
              height: 32.0,
              alignment: Alignment.center,
              child: ToggleButtons(
                fillColor: Color(0xff0cce6b),
                borderRadius: BorderRadius.circular(30.0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Gebucht'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Angeboten'),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                        print('angeboten');
                      } else {
                        isSelected[buttonIndex] = false;
                        print('gebucht');
                      }
                    }
                  });
                },
                isSelected: isSelected,
              ),
            ),
          ),
        ),
      ),
      body: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new PreferredSize(
            child: new Container(
              color: Color(0xff0cce6b),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    new Expanded(child: new Container()),
                    new TabBar(
                        tabs: [new Text('Zukünftig'), new Text('Vergangen')])
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight),
          ),
        ),
      ),
    );
  }
}

/*
body: new TabBarView(
children: <Widget>[
new Column(
children: <Widget>[
new Column(
children: <Widget>[new Text('Zukünftig')],
),
new Column(
children: <Widget>[new Text('Vergangen')],
)
],
)
],
),

 */

/*
new DefaultTabController(
length: 2,
child: new Scaffold(
appBar: new PreferredSize(
child: new Container(
color: Color(0xff0cce6b),
child: SafeArea(
child: Column(
children: <Widget>[
new Expanded(child: new Container()),
new TabBar(
tabs: [new Text('Vergangen'), new Text('Zukünftig')])
],
),
),
),
preferredSize: Size.fromHeight(kToolbarHeight),
),
),
),

 */
