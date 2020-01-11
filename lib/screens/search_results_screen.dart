import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/screens/profile_screen.dart';
import 'package:leaf/services/database_service.dart';

class SearchResultsScreen extends StatefulWidget {
  String origin;

  SearchResultsScreen(this.origin);

  static final String id = 'search_results_screen';
  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  static List searchParameters;

  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _users;
  Future<QuerySnapshot> _rides =
      DatabaseService.searchRides('München', 'Freiburg');

  _buildUserTile(User user) {
    return ListTile(
      leading: CircleAvatar(
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
      /*
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: user.profileImageUrl.isEmpty
            ? AssetImage('assets/images/logo.png')
            : CachedNetworkImageProvider(user.profileImageUrl),
      ),
       */

      title: Text(ride.origin),
      children: <Widget>[
        Text(ride.destination),
      ],
      /*
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(
            userId: user.id,
          ),
        ),
      ),
       */
    );
  }

  _clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _rides = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String origin = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title: Text('Ergebnisse')),
      body: FutureBuilder(
        future: DatabaseService.searchRides(origin, 'Konstanz'),
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
                print(origin);
                return _buildRideCard(ride);
              });
        },
      ),
    );
  }

  //Methodenaufruf
/*
onSubmitted: (input) {
            if (input.isNotEmpty) {
              setState(() {
                _rides = DatabaseService.searchRides(input);
              });
            }
          },
 */
}
