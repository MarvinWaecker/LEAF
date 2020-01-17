import 'package:cloud_firestore/cloud_firestore.dart';

class Ride{
  final String id;
  final String creatorId;
  final String origin;
  final String destination;
  final String date;
  final String time;
  final String price;

  Ride({
    this.id,
    this.creatorId,
    this.origin,
    this.destination,
    this.date,
    this.time,
    this.price,

});


  factory Ride.fromDoc(DocumentSnapshot doc) {
    return Ride(
      id: doc.documentID,
      creatorId: doc['creatorId'],
      origin:  doc['origin'],
      destination: doc['destination'],
      date: doc['date'],
      time: doc['time'],
      price: doc['price']
    );
  }
}