import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guanasfires/models/user.dart';
import 'package:guanasfires/services/auth_services/sign_in.dart';

class Register_Token {
  Register_Token() {
    registerToken();
  }

  Timer _timer;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;
  List<User> usersList = new List();

  Query _userQuery;

  Future<String> registerToken() async {
    await register();

    return 'Register token progress';
  }

  Future<void> register() async {
    usersList = new List();
    _userQuery = _database.reference().child("users").orderByChild("userId");
    _onTodoAddedSubscription = _userQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription =
        _userQuery.onChildChanged.listen(onEntryChanged);
    registerT();
  }

  void registerT() {
    _timer = new Timer(const Duration(milliseconds: 5000), () {
      bool existe = false;
      User userAux;
      for (int i = 0; i < usersList.length; i++) {
        if (usersList[i].email == email) {
          admin = usersList[i].admin;
          userAux = usersList[i];
          existe = true;
        }
      }
      print("Admin:" + admin.toString());

      if (!existe) {
        User user = new User(email, email, false, imageUrl, token);

        _database.reference().child("tokens").push().set({"token": token});
      } else {
        userAux.token = token;
        _database
            .reference()
            .child("tokens")
            .child(token)
            .push()
            .set({"token": token});
      }
    });
  }

  onEntryChanged(Event event) {
    var oldEntry = usersList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    usersList[usersList.indexOf(oldEntry)] = User.fromSnapshot(event.snapshot);
  }

  onEntryAdded(Event event) {
    usersList.add(User.fromSnapshot(event.snapshot));
  }
}
