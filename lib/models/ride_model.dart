import 'package:cloud_firestore/cloud_firestore.dart';

class Ride{
  final String id;
  final String origin;
  final String destination;
  final String date;
  final String time;

  Ride({
    this.id,
    this.origin,
    this.destination,
    this.date,
    this.time,
});

  factory Ride.fromDoc(DocumentSnapshot doc) {
    return Ride(
      id: doc.documentID,
      origin:  doc['origin'],
      destination: doc['destination'],
      date: doc['date'],
      time: doc['time'],
    );
  }
}