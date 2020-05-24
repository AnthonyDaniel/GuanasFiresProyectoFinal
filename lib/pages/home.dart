
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle:
        Text("Inicio"),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              child: Text(
                  "Inicio"
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              child: Text(
                  "Inicio"
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}