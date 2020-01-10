import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf/icons/leaf_icons_icons.dart';
import 'package:leaf/models/user_data.dart';
import 'package:leaf/screens/activity_screen.dart';
import 'package:leaf/screens/create_ride_screen.dart';
import 'package:leaf/screens/home_screen.dart';
import 'package:leaf/screens/profile_screen.dart';
import 'package:leaf/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class mainBarScreen extends StatefulWidget {
  @override
  _MainBarScreenState createState() => _MainBarScreenState();
}

class _MainBarScreenState extends State<mainBarScreen> {
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
    _pageController.animateToPage(
      1,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  void toCreateRideScreen() {
    setState(() {
      _currentTab = 2;
    });
    _pageController.animateToPage(
      2,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomeScreen(
            toSearchScreen: toSearchScreen,
            toCreateRideScreen: toCreateRideScreen,
          ),
          SearchScreen(),
          CreateRideScreen(),
          ActivityScreen(),
          ProfileScreen(userId: Provider.of<UserData>(context).currentUserId),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: _currentTab,
          onTap: (int index) {
            setState(() {
              _currentTab = index;
            });
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          activeColor: Colors.green,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
              Icons.home,
              size: 32.0,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.search,
              size: 32.0,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              LeafIcons.biete,
              size: 17.0,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.directions_car,
              size: 32.0,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.account_circle,
              size: 32.0,
            ))
          ]),
    );
  }
}
