import 'package:flutter/material.dart';
import 'package:guanasfires/services/auth_services/sign_in.dart';
import 'package:guanasfires/theme/colors/light_colors.dart';

import '../login.dart';

Widget fullAppbar(context){
  Sign_In googleAuth = new Sign_In();

  var text = "";
  if(admin){
    text = "Usuario Administrador";
  }else{
    text = "Usuario Regular";
  }

  void showDialogSignOut() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Cerrar sesión"),
          content: new Text("¿Estas seguro de cerrar sesión?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
                child: new Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                }
            ),
            new FlatButton(
              child: new Text("Si"),
              onPressed: () {
                googleAuth.signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }), ModalRoute.withName('/'));
              },
            ),
          ],
        );
      },
    );
  }

  return AppBar(
    automaticallyImplyLeading: false,
      title: Container(
        child: CircleAvatar(
          backgroundColor: LightColors.kBlue,
          radius: 20.0,
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
      ),
      flexibleSpace: Container(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
             "",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600,color: LightColors.kLightGreen),
            ),
            Text(
              'Hola!,' + name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: LightColors.kLightGreen),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,color: LightColors.kLightGreen),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: (Icon(Icons.input,color: LightColors.kLightGreen, size: 30.0)),
          onPressed: () {
            showDialogSignOut();
          },
        ),
      ],
  );
}