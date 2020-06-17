import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:guanasfires/models/canton.dart';
import 'package:guanasfires/models/distritos.dart';
import 'package:guanasfires/models/provincia.dart';
import 'dart:async';
import 'package:guanasfires/models/user.dart';
import 'package:guanasfires/services/locationsServices.dart';

String name;
String email;
String imageUrl;
bool admin;

List<Provincia> provincias = new List<Provincia>();
List<Canton> cantones = new List<Canton>();
List<Distrito> distritos = new List<Distrito>();
List<User> usersList = new List();
class Sign_In {

  Sign_In(){
  }

  LocationsServices _locationsServices = new LocationsServices();

  Timer _timer;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _userQuery;

  Future<String> signInWithGoogle() async {

    name = "";
    email = "";
    imageUrl = "";
    admin = false;

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

    provincias = _locationsServices.provincias;
    cantones =_locationsServices.cantones;
    distritos = _locationsServices.distritos;

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
     usersList = new List();
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
      for(int i = 0; i < usersList.length; i++){
        if(usersList[i].email == email){
          admin=usersList[i].admin;
          existe = true;
        }
      }
      print("Admin:" + admin.toString());
      if(!existe){
        User user = new User(email, email, false,imageUrl);
        _database.reference().child("users").push().set(user.toJson());
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