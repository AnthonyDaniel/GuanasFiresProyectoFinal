import 'package:flutter/material.dart';

Drawer listFires() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: const <Widget>[
        ListTile(
          title: Text(
            'Tus incendios',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('Messages'),
        ),
        ListTile(
          title: Text(
            'Incendios pendientes',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),
        Divider(),
      ],
    ),
  );
}
