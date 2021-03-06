import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/screens/profile_screen.dart';
import 'package:leaf/services/database_service.dart';

/*
class SearchScreen extends StatefulWidget {


  @override
  _SearchScreenState createState() => _SearchScreenState();
  static final String id = 'search_screen';
}

class _SearchScreenState extends State<SearchScreen> {
TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _users;
  Future<QuerySnapshot> _rides;
  
  int _currentSearchTab = 0;
  PageController _searchPageController;
  // TextEditingController _searchController = TextEditingController();
  // Future<QuerySnapshot> _users;

  void toSearchLocationScreen() {
    /*
    setState(() {
      _currentSearchTab = 1;
    });

     */
    //_searchPageController.nextPage(duration: Duration(milliseconds: 100), curve: Curves.easeIn);
    _currentSearchTab = 1;
    _searchPageController.animateToPage(
      1,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );


  }
  void toSearchTimeScreen() {
    setState(() {
      _currentSearchTab = 2;
    });

    //_searchPageController.nextPage(duration: Duration(milliseconds: 100), curve: Curves.easeIn);
    _currentSearchTab = 2;
    _searchPageController.animateToPage(
      2,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: PageView(
        controller: _searchPageController,
        children: <Widget>[
          SearchLocationScreen(
          ),
          SearchTimeScreen(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentSearchTab = index;
          });
        },
      ),


  /*
  _buildUserTile(User user) {
    return ListTile(
      leading: (
        radius: 20.0,
        backgroundImage: user.profileImageUrl.isEmpty
            ? AssetImage('assets/images/logo.png')
            : CachedNetworkImageProvider(user.profileImageUrl),
      ),
      title: Text(user.name),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(
            userId: user.id,
          ),
        ),
      ),
    );
  }

  _buildRideCard(Ride ride) {
    return ExpansionTile(

      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: user.profileImageUrl.isEmpty
            ? AssetImage('assets/images/logo.png')
            : CachedNetworkImageProvider(user.profileImageUrl),
      ),


      title: Text(ride.origin),
      children: <Widget>[
      ],

      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(
            userId: user.id,
          ),
        ),
      ),


    );
  }

  _clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _rides = null;
    });
  }







      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            border: InputBorder.none,
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              size: 30.0,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
              ),
              onPressed: _clearSearch,
            ),
            filled: true,
          ),
          onSubmitted: (input) {
            if (input.isNotEmpty) {
              setState(() {
                _rides = DatabaseService.searchRides(input);
              });
            }
          },
        ),
      ),
      body: _rides == null
          ? Center(
              child: Text('Search here'),
            )
          : FutureBuilder(
              future: _rides,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data.documents.length == 0) {
                  return Center(
                    child: Text('No users found.'),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      Ride ride = Ride.fromDoc(snapshot.data.documents[index]);
                      return _buildRideCard(ride);
                    });
              },
            ),
      */
    );
  }
}



 */
