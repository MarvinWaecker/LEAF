import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String profileImageUrl;
  final String email;
  final String bio;
  final String music;
  final String car;
  final String mood;
  final String smoke;
  final String pay;

  User({
    this.id,
    this.name,
    this.profileImageUrl,
    this.email,
    this.bio,
    this.music,
    this.car,
    this.mood,
    this.smoke,
    this.pay
  });

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      name: doc['name'],
      profileImageUrl: doc['profileImageUrl'],
      email: doc['email'],
      bio: doc['bio'] ?? '',
      music: doc['music'] ?? '',
      car: doc['car'] ?? '',
      mood: doc['mood'],
      smoke: doc['smoke'],
      pay: doc['pay'] ?? '',
    );
  }
}
