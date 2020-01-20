import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/models/user_data.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


class DatabaseService {
  static final _firestore = Firestore.instance;

  static void updateUser(User user) {
    usersRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'bio': user.bio,
      'music': user.music,
      'car': user.car,
      'mood': user.mood,
      'smoke': user.smoke,
    });
  }

  static void createRide(Ride ride, BuildContext context) {
    var uuid = Uuid();
    _firestore.collection('/rides').document(uuid.v1()).setData({
      'origin': ride.origin,
      'destination': ride.destination,
      'time': ride.time,
      'date': ride.date,
      'creatorId': Provider.of<UserData>(context, listen: false).currentUserId,
      'price': ride.price,
    });
  }

  static void updateRide(Ride ride, BuildContext context) {
    ridesRef.document(ride.id).updateData({
      'passenger1': Provider.of<UserData>(context, listen: false).currentUserId,
    });
  }

  static void updatePay(User user, String pay) {
    usersRef.document(user.id).updateData({
      'pay': pay,
    });
  }

  static Future<QuerySnapshot> searchRides(
      String origin, String destination, String date, String time) {
    Future<QuerySnapshot> rides = _firestore
        .collection('rides')
        .where('origin', isEqualTo: origin)
        .where('destination', isEqualTo: destination)
        .where('date', isEqualTo: date)
        .where('time', isEqualTo: time)
        .getDocuments();
    return rides;
  }

  /*
  static Future<QuerySnapshot> getUserData(String creatorId) {
    Future<QuerySnapshot> data =  _firestore
        .collection('users')
        .where('creatorId', isEqualTo: creatorId)
        .getDocuments();

    return data;
  }

   */

  /*
  static Future<QuerySnapshot> getUserData(String creatorId) {
   Future<DocumentSnapshot> data = _firestore.collection('users').document(creatorId).snapshots();

    return data;
  }

   */

  //Übersicht
  static Future<QuerySnapshot> futureRidesCreated(context){
    String id = Provider.of<UserData>(context).currentUserId;

    final dateFormatter = DateFormat("dd.MM.yyyy");
    String dateNow = dateFormatter.format(DateTime.now());

    Future<QuerySnapshot> rides = _firestore
        .collection('rides')
    .where('creatorId', isEqualTo: id)
    .where('date', isGreaterThan: dateNow)
        .getDocuments();

    return rides;
    
  }

  static Future<QuerySnapshot> futureRidesBooked(context){
    String id = Provider.of<UserData>(context).currentUserId;

    final dateFormatter = DateFormat("dd.MM.yyyy");
    String dateNow = dateFormatter.format(DateTime.now());

    Future<QuerySnapshot> rides = _firestore
        .collection('rides')
        .where('passenger1', isEqualTo: id)
        .where('date', isGreaterThan: dateNow)
        .getDocuments();

    return rides;
  }

  static Future<QuerySnapshot> pastRidesCreated(BuildContext context){
    String id = Provider.of<UserData>(context).currentUserId;

    final dateFormatter = DateFormat("dd.MM.yyyy");
    String dateNow = dateFormatter.format(DateTime.now());

    Future<QuerySnapshot> rides = _firestore
        .collection('rides')
        .where('creatorId', isEqualTo: id)
        .where('date', isLessThan: dateNow)
        .getDocuments();

    return rides;

  }

  static Future<QuerySnapshot> pastRidesBooked(BuildContext context){
    String id = Provider.of<UserData>(context).currentUserId;

    final dateFormatter = DateFormat("dd.MM.yyyy");
    String dateNow = dateFormatter.format(DateTime.now());

    Future<QuerySnapshot> rides = _firestore
        .collection('rides')
        .where('passenger1', isEqualTo: id)
        .where('date', isGreaterThan: dateNow)
        .getDocuments();

    return rides;
  }
}
