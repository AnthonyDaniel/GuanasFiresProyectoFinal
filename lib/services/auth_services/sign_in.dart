import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:guanasfires/models/user.dart';

String name;
String email;
String imageUrl;
bool admin;

class Sign_In {
  Timer _timer;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  List<User> _usersList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _userQuery;

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =  await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoUrl;

    await isAdmin();

    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'Inicio de sesión exitoso: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("Has cerrado sesión");
  }

  Future<void> isAdmin() async {
    _usersList = new List();
    _userQuery = _database
        .reference()
        .child("users")
        .orderByChild("userId");
    _onTodoAddedSubscription = _userQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription =  _userQuery.onChildChanged.listen(onEntryChanged);
    addNewUser();
  }

  void addNewUser(){
    _timer = new Timer(const Duration(milliseconds: 5000), () {
      bool existe = false;
      for(int i = 0; i < _usersList.length; i++){
        if(_usersList[i].email == email){
          admin=_usersList[i].admin;
          existe = true;
        }
      }
      print("Admin:" + admin.toString());
      if(!existe){
        User user = new User(email, email, false);
        _database.reference().child("users").push().set(user.toJson());
      }
    });
  }

  onEntryChanged(Event event) {
    var oldEntry = _usersList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    _usersList[_usersList.indexOf(oldEntry)] = User.fromSnapshot(event.snapshot);
  }

  onEntryAdded(Event event) {
    _usersList.add(User.fromSnapshot(event.snapshot));
  }
}