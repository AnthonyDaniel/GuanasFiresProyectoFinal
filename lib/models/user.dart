import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String subject;
  bool admin;
  String userId;

  User(this.subject, this.userId, this.admin);

  User.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        userId = snapshot.value["userId"],
        subject = snapshot.value["subject"],
        admin = snapshot.value["admin"];

  toJson() {
    return {
      "userId": userId,
      "subject": subject,
      "admin": admin,
    };
  }
}