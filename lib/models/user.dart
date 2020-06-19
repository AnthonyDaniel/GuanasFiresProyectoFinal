import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String email;
  bool admin;
  String userId;
  String imageUrl;
  String token;

  User(this.email, this.userId, this.admin, this.imageUrl, this.token);

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        userId = snapshot.value["userId"],
        email = snapshot.value["email"],
        admin = snapshot.value["admin"],
        imageUrl = snapshot.value["imageUrl"],
        token = snapshot.value["token"];
  toJson() {
    return {
      "userId": userId,
      "email": email,
      "admin": admin,
      "imageUrl": imageUrl,
      "token": token,
    };
  }
}
