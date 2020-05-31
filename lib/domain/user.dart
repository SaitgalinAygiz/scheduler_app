import 'package:firebase_auth/firebase_auth.dart';

class User {
  String name;
  String phoneNumber;
  String id;

  User.fromFirebase(FirebaseUser firebaseUser) {
    id = firebaseUser.uid;
    phoneNumber = firebaseUser.phoneNumber;
    name = firebaseUser.displayName;
  }

  User({this.name, this.id, this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['_id']
    );
  }
}