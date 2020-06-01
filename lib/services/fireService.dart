
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:guanasfires/models/fire.dart';
import 'dart:async';


class FireService{

  List<Fire> _fireList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _userQuery;

  addNewFire(String todoItem) {
    if (todoItem.length > 0) {
     // Fire todo = new Fire(todoItem.toString());
    //  _database.reference().child("users").push().set(todo.toJson());
    }
  }

  updateFire(Fire todo) {
    //Toggle completed
    
    if (todo != null) {
      _database.reference().child("fires").child(todo.key).set(todo.toJson());
    }
  }

  deleteFire(String todoId, int index) {
    _database.reference().child("fires").child(todoId).remove().then((_) {
      print("Delete $todoId successful");
      
        _fireList.removeAt(index);
      
    });
  }
  onEntryChanged(Event event) {
    var oldEntry = _fireList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    _fireList[_fireList.indexOf(oldEntry)] = Fire.fromSnapshot(event.snapshot);
  }

  onEntryAdded(Event event) {
    _fireList.add(Fire.fromSnapshot(event.snapshot));
  }
}