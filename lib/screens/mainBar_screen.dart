import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf/icons/leaf_icons_icons.dart';
import 'package:leaf/models/user_data.dart';
import 'package:leaf/screens/rides_overview_screen.dart';
import 'package:leaf/screens/create_pages.dart';
import 'package:leaf/screens/home_screen.dart';
import 'package:leaf/screens/profile_screen.dart';
import 'package:leaf/screens/search_pages.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class MainBarScreen extends StatefulWidget {
  final test;

  MainBarScreen(this.test);

  @override
  _MainBarScreenState createState() => _MainBarScreenState(test);
}

class _MainBarScreenState extends State<MainBarScreen> {
  final test;

  _MainBarScreenState(this.test);

  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void toSearchScreen() {
    setState(() {
      _currentTab = 1;
    });
    _pageController.jumpToPage(
      1,
    );
  }
  void toCreateRideScreen() {
    setState(() {
      _currentTab = 2;
    });
    _pageController.jumpToPage(
      2,
    );
  }
  void toActivityScreen() {
    setState(() {
      _currentTab = 3;
    });
    _pageController.jumpToPage(
      3,
    );
  }

  @override
  Widget build(BuildContext context) {
    int test = widget.test;

    /// StatusBar Text weiß machen
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
        physics: new NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          HomeScreen(
            toSearchScreen: toSearchScreen,
            toCreateRideScreen: toCreateRideScreen,
          ),
          SearchPages(),
          CreatePages(),
          ActivityScreen(),
          ProfileScreen(userId: Provider.of<UserData>(context).currentUserId),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 15)]),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xff111e2e),
          iconSize: 25,
          selectedFontSize: 12,
          showUnselectedLabels: false,
          currentIndex: _currentTab,
          onTap: (int index) {
            setState(() {
              _currentTab = index;
            });
            _pageController.jumpToPage(
              index,
            );
          },
          // activeColor: Color(0xff0cce6b),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontFamily: 'UbuntuRegular',
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              title: Text(
                'Suchen',
                style: TextStyle(fontFamily: 'UbuntuRegular'),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                LeafIcons.anbieten_hand___fluttericons,
                size: 32,
              ),
              title: Text(
                'Anbieten',
                style: TextStyle(fontFamily: 'UbuntuRegular'),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.directions_car,
              ),
              title: Text(
                'Fahrten',
                style: TextStyle(fontFamily: 'UbuntuRegular'),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text(
                'Profil',
                style: TextStyle(fontFamily: 'UbuntuRegular'),
              ),
            )
          ],
          selectedItemColor: Color(0xff0cce6b),
          unselectedItemColor: Color(0xffE6EFE9),
        ),
      ),
    );
  }
}
