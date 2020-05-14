
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddFire extends StatelessWidget {
  const AddFire();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle:
        Text("Añadir fuego"),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              child: Text(
                  "Añadir fuego"
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              child: Text(
                  "Añadir fuego"
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}