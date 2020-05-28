import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String email;
  bool admin;
  String userId;

  User(this.email, this.userId, this.admin);

  User.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        userId = snapshot.value["userId"],
        email = snapshot.value["email"],
        admin = snapshot.value["admin"];

  toJson() {
    return {
      "userId": userId,
      "email": email,
      "admin": admin,
    };
  }
}