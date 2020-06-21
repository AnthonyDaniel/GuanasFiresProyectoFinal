import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guanasfires/models/fire.dart';
import 'package:guanasfires/pages/map_home.dart';
import 'package:guanasfires/services/auth_services/sign_in.dart';
import 'package:guanasfires/services/fireService.dart';

Drawer listFires(MapHomeState servicesHome, FireService f) {
  return Drawer(
      child: Column(
    children: <Widget>[
      Container(
        height: 50.0,
        color: Colors.green,
        child: Center(
          child: Text("Incendios mios",
              style: TextStyle(fontSize: 15.0, color: Colors.white)),
        ),
      ),
      Expanded(
        child: showFiresYou(servicesHome, f),
      ),
      Container(
        height: 50.0,
        color: Colors.green,
        child: Center(
          child: Text("Incendios pendientes",
              style: TextStyle(fontSize: 15.0, color: Colors.white)),
        ),
      ),
      Expanded(
        child: showFiresPendings(servicesHome, f),
      ),
      Container(
        height: 50.0,
        color: Colors.green,
        child: Center(
          child: Text("Todos los incendios",
              style: TextStyle(fontSize: 15.0, color: Colors.white)),
        ),
      ),
      Expanded(
        child: showFiresPendings(servicesHome, f),
      ),
    ],
  ));
}

Widget showFiresYou(MapHomeState servicesHome, f) {
  List<Fire> fire = new List<Fire>();

  for (int i = 0; i < fireList.length; i++) {
    if (fireList.elementAt(i).email == email) {
      fire.add(fireList.elementAt(i));
    }
  }

  return ListView.builder(
      shrinkWrap: true,
      itemCount: fire.length,
      itemBuilder: (BuildContext context, int index) {
        String key = fire[index].key;
        String email = fire[index].email;
        String canton = fire[index].canton;
        double lat = fire[index].lat;
        double log = fire[index].long;
        return Dismissible(
          key: Key(key),
          background: Container(color: Colors.red),
          onDismissed: (direction) async {
            f.deleteFire(key, index);
            servicesHome.loadMarkdRemove(key);
            Fluttertoast.showToast(
                msg: "Eliminado",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pop(context);
          },
          child: ListTile(
            title: Text(
              "Incendios " + lat.toString() + "  " + log.toString(),
              style: TextStyle(fontSize: 15.0),
            ),
            subtitle: Text(
              "Reportado por: " + email + " en " + canton,
              style: TextStyle(fontSize: 11.0),
            ),
            leading: Icon(Icons.location_on, color: Colors.grey, size: 20.0),
            trailing: Icon(Icons.edit, color: Colors.grey, size: 20.0),
            onTap: () {
              servicesHome.recolocarCamara(lat, log);
              Navigator.pop(context);
            },
          ),
        );
      });
}

Widget showFiresPendings(MapHomeState servicesHome, f) {
  List<Fire> fire = new List<Fire>();

  for (int i = 0; i < fireList.length; i++) {
    if (fireList.elementAt(i).state == true) {
      fire.add(fireList.elementAt(i));
    }
  }

  return ListView.builder(
      shrinkWrap: true,
      itemCount: fire.length,
      itemBuilder: (BuildContext context, int index) {
        String key = fire[index].key;
        String email = fire[index].email;
        String canton = fire[index].canton;
        double lat = fire[index].lat;
        double log = fire[index].long;
        return Dismissible(
          key: Key(key),
          background: Container(color: Colors.red),
          onDismissed: (direction) async {
            if (admin) {
              f.deleteFire(key, index);
              servicesHome.loadMarkdRemove(key);
              Fluttertoast.showToast(
                  msg: "Eliminado",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              Fluttertoast.showToast(
                  msg: "No eliminado, necesitas permisos",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }

            Navigator.pop(context);
          },
          child: ListTile(
            title: Text(
              "Incendios " + lat.toString() + "  " + log.toString(),
              style: TextStyle(fontSize: 15.0),
            ),
            subtitle: Text(
              "Reportado por: " + email + " en " + canton,
              style: TextStyle(fontSize: 11.0),
            ),
            leading: Icon(Icons.location_on, color: Colors.grey, size: 20.0),
            trailing: Icon(Icons.edit, color: Colors.grey, size: 20.0),
            onTap: () {
              servicesHome.recolocarCamara(lat, log);
              Navigator.pop(context);
            },
          ),
        );
      });
}

Widget showFiresAll(MapHomeState servicesHome, f) {
  List<Fire> fire = new List<Fire>();

  for (int i = 0; i < fireList.length; i++) {
    fire.add(fireList.elementAt(i));
  }

  return ListView.builder(
      shrinkWrap: true,
      itemCount: fire.length,
      itemBuilder: (BuildContext context, int index) {
        String key = fire[index].key;
        String email = fire[index].email;
        String canton = fire[index].canton;
        double lat = fire[index].lat;
        double log = fire[index].long;
        return Dismissible(
          key: Key(key),
          background: Container(color: Colors.red),
          onDismissed: (direction) async {
            if (admin) {
              f.deleteFire(key, index);
              servicesHome.loadMarkdRemove(key);
              Fluttertoast.showToast(
                  msg: "Eliminado",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              Fluttertoast.showToast(
                  msg: "No eliminado, necesitas permisos",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            Navigator.pop(context);
          },
          child: ListTile(
            title: Text(
              "Incendios " + lat.toString() + "  " + log.toString(),
              style: TextStyle(fontSize: 15.0),
            ),
            subtitle: Text(
              "Reportado por: " + email + " en " + canton,
              style: TextStyle(fontSize: 11.0),
            ),
            leading: Icon(Icons.location_on, color: Colors.grey, size: 20.0),
            trailing: Icon(Icons.edit, color: Colors.grey, size: 20.0),
            onTap: () {
              servicesHome.recolocarCamara(lat, log);
              Navigator.pop(context);
            },
          ),
        );
      });
}
