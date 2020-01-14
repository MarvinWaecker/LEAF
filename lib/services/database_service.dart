import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      'music': user.music,
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
      'time': ride.time,
      'date': ride.date,
      'creatorId': Provider.of<UserData>(context, listen: false).currentUserId,
    });
  }

  static void updateRide(Ride ride) {

  }

  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users =
        usersRef.where('name', isGreaterThanOrEqualTo: name).getDocuments();
    return users;
  }
/*
  static Future<QuerySnapshot> searchRides(String origin) {
    Future<QuerySnapshot> rides =
        ridesRef.where('origin', isEqualTo: origin).getDocuments();
    return rides;
  }

 */

  static Future<QuerySnapshot> searchRides(String origin , String destination) {
    //Future<QuerySnapshot> ridesOrigin = ridesRef.where('origin', isEqualTo: origin).getDocuments();

    //Future<QuerySnapshot> ridesDestination = ridesRef.where('destination', isEqualTo: destination).getDocuments();

    Future<QuerySnapshot> rides = Firestore.instance.collection('rides').where('origin', isEqualTo: origin).where('destination', isEqualTo: destination).getDocuments();



    //ridesRef.where('origin', isGreaterThanOrEqualTo: origin).where('destination', isEqualTo: destination).getDocuments();
    
    return rides;
    }
}

