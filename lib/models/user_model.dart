import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String id;
  final String name;
  final String profileImageUrl;
  final String email;
  final String bio;
  final String music;

  User({
    this.id,
    this.name,
    this.profileImageUrl,
    this.email,
    this.bio,
    this.music
});

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      name: doc['name'],
      profileImageUrl: doc['profileImageUrl'],
      email: doc['email'],
      bio: doc['bio'] ?? '',
      music: doc['music'] ?? '',
    );
  }
}