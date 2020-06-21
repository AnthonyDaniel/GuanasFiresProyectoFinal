import 'package:flutter/material.dart';
import 'package:guanasfires/models/fire.dart';
import 'package:guanasfires/services/auth_services/sign_in.dart';
import 'package:guanasfires/services/fireService.dart';

Drawer listFires() {
  return Drawer(
    child: Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "Incendios tuyos",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          //showFiresYou(),
        ],
      ),
    ),
  );
}

Widget showFiresYou() {
  List<Fire> fire = new List<Fire>();

  for (int i = 0; i < fireList.length; i++) {
    if (fireList.elementAt(i).email == email) {
      fire.add(fireList.elementAt(i));
    }
  }

  if (fireList.length > 0) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: fireList.length,
        itemBuilder: (BuildContext context, int index) {
          String key = fireList[index].key;
          String email = fireList[index].email;
          double lat = fireList[index].lat;
          double log = fireList[index].long;
          return Dismissible(
            key: Key(key),
            background: Container(color: Colors.red),
            onDismissed: (direction) async {
              //uServ.deleteUser(key, index);
            },
            child: ListTile(
              title: Text(
                "Incendios " + lat.toString() + "  " + log.toString(),
                style: TextStyle(fontSize: 15.0),
              ),
              subtitle: Text(
                email,
                style: TextStyle(fontSize: 11.0),
              ),
              leading: Icon(Icons.location_on, color: Colors.grey, size: 20.0),
              trailing: Icon(Icons.edit, color: Colors.grey, size: 20.0),
            ),
          );
        });
  }
}
