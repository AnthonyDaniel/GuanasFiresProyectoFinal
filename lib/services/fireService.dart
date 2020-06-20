import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guanasfires/models/fire.dart';

List<Fire> fireList;

class FireService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _userQuery;

  FireService() {
    fireList = new List();
    _userQuery = _database.reference().child("fires").orderByChild("key");
    _onTodoAddedSubscription = _userQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription =
        _userQuery.onChildChanged.listen(onEntryChanged);
  }

  Future<String> addNewFire(Fire fire) async {
    _database.reference().child("fires").push().set(fire.toJson());
    return "Se ha agregado correctamente";
  }

  updateFire(Fire todo) {
    _database.reference().child("fires").child(todo.key).set(todo.toJson());
  }

  deleteFire(String todoId, int index) {
    _database.reference().child("fires").child(todoId).remove().then((_) {
      print("Delete $todoId successful");
      fireList.removeAt(index);
    });
  }

  onEntryChanged(Event event) {
    var oldEntry = fireList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    fireList[fireList.indexOf(oldEntry)] = Fire.fromSnapshot(event.snapshot);
  }

  onEntryAdded(Event event) {
    fireList.add(Fire.fromSnapshot(event.snapshot));
  }
}
