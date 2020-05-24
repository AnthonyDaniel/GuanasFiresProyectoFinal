import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String subject;
  bool completed;
  String userId;

  User(this.subject, this.userId, this.completed);

  User.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        userId = snapshot.value["userId"],
        subject = snapshot.value["subject"],
        completed = snapshot.value["completed"];

  toJson() {
    return {
      "userId": userId,
      "subject": subject,
      "completed": completed,
    };
  }
}