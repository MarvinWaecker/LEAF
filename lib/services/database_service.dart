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

  static String searchUser5(creatorId) {
    usersRef.document(creatorId).get();
  }

  static void createRide(Ride ride, BuildContext context) {
    var uuid = Uuid();
    _firestore.collection('/rides').document(uuid.v1()).setData({
      'origin': ride.origin,
      'destination': ride.destination,
      'time': ride.time,
      'date': ride.date,
      'creatorId': Provider.of<UserData>(context, listen: false).currentUserId,
    });
  }

  static void updateRide(Ride ride) {}

  static Future<QuerySnapshot> searchUsers(String creatorId) {
    Future<QuerySnapshot> users = usersRef
        .where('name', isGreaterThanOrEqualTo: creatorId)
        .getDocuments();
    return users;
  }

  static Future<List<String>> searchUser(String creatorId) async {
    List<String> userInfo;
    //User user = usersRef.where('name', isGreaterThanOrEqualTo: creatorId).getDocuments();
    DocumentSnapshot document =
        await Firestore.instance.collection('users').document(creatorId).get();

    userInfo.add(document['name']);
    userInfo.add(document['bio']);
    userInfo.add(document['music']);
    userInfo.add(document['car']);
    userInfo.add(document['mood']);
    userInfo.add(document['smoke']);
    userInfo.add(document['pet']);

    return userInfo;
  }

  static Future<QuerySnapshot> getData(creatorId) async {
    return await Firestore.instance.collection('users').getDocuments();
  }

  static String userSearch6(creatorId) {
    getData(creatorId).then((val) {
      if (val.documents.length > 0) {
        print(val.documents[0].data['name']);
      }
    });
  }

  static Future<String> userSearch2(creatorId) async {
    DocumentSnapshot snapshot =
        await Firestore.instance.collection('users').document(creatorId).get();

    var name = snapshot['name'];
    if (name is String) {
      return await name;
    }
  }

  static void userSearch3(creatorId) {
    //DocumentSnapshot snapshot=  Firestore.instance.collection('users').document(creatorId).get();
    String sn =
        Firestore.instance.collection('users').document(creatorId).toString();

    /*
    var name = snapshot['name'];
    if (name is String) {
      return await name;
    }

     */
    print(sn);
  }


  static String userSearch(creatorId) {
    List<String> userData = List<String>();
    String name;
    String bio;
    String music;
    String car;
    String mood;
    String smoke;
    String pet;


    var documentName = Firestore.instance
        .collection('users')
        .document(creatorId)
        .get()
        .then((DocumentSnapshot snapshot) {
      String name = (snapshot.data['name'].toString());
      print ('DataBase: ' + name);
      return name;
    });




    /*
    var documentBio = Firestore.instance
        .collection('users')
        .document(creatorId)
        .get()
        .then((DocumentSnapshot) =>
            bio = DocumentSnapshot.data['bio'].toString());
    userData.add(bio);

    var documentMusic = Firestore.instance
        .collection('users')
        .document(creatorId)
        .get()
        .then((DocumentSnapshot) =>
            name = DocumentSnapshot.data['music'].toString());
    userData.add(music);

    var documentCar = Firestore.instance
        .collection('users')
        .document(creatorId)
        .get()
        .then((DocumentSnapshot) =>
            name = DocumentSnapshot.data['car'].toString());
    userData.add(car);

    var documentMood = Firestore.instance
        .collection('users')
        .document(creatorId)
        .get()
        .then((DocumentSnapshot) =>
            userData.add(DocumentSnapshot.data['mood'].toString()));
    userData.add(mood);

    var documentSmoke = Firestore.instance
        .collection('users')
        .document(creatorId)
        .get()
        .then((DocumentSnapshot) =>
            name = DocumentSnapshot.data['smoke'].toString());
    userData.add(smoke);

    var documentPet = Firestore.instance
        .collection('users')
        .document(creatorId)
        .get()
        .then((DocumentSnapshot) =>
            name = DocumentSnapshot.data['pet'].toString());
    userData.add(pet);

     */

    //return userData;
    //print(userData[0]);
  }

  static Future<QuerySnapshot> searchRides(
      String origin, String destination, String date, String time) {
    Future<QuerySnapshot> rides = Firestore.instance
        .collection('rides')
        .where('origin', isEqualTo: origin)
        .where('destination', isEqualTo: destination)
        .where('date', isEqualTo: date)
        .where('time', isEqualTo: time)
        .getDocuments();
    return rides;
  }


}
