import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/models/user_data.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


class DatabaseService {
  static final _firestore = Firestore.instance;

  static void updateUser(User user) {
    usersRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'bio': user.bio,
    });
  }

  static void createRide(Ride ride, BuildContext context) {
    var uuid = Uuid();
    _firestore
        .collection('/rides')
        .document(uuid.v1())
        .setData({
      'origin': ride.origin,
      'destination': ride.destination,
      'creatorId': Provider.of<UserData>(context).currentUserId,
    });
  }

  static void updateRide(Ride ride) {

  }

  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users =
        usersRef.where('name', isGreaterThanOrEqualTo: name).getDocuments();
    return users;
  }

  static Future<QuerySnapshot> searchRides(String origin) {
    Future<QuerySnapshot> rides =
        ridesRef.where('origin', isGreaterThanOrEqualTo: origin).getDocuments();
    return rides;
  }
}

