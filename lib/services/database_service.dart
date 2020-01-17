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
      'car': user.car,
      'mood': user.mood,
      'smoke': user.smoke,
      'pet': user.pet,
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

  static getUser() {
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users');

    userRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
    });
  }

  static Future<String> getRiderTest(String creatorId) async {
    var document = await Firestore.instance
        .collection('users')
        .document(creatorId)
        .get()
        .then((DocumentSnapshot snap) => snap.data);

    return document['name'];
  }
}
