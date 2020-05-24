
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pending extends StatelessWidget {
  const Pending();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle:
        Text("Pendiente"),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              child: Text(
                  "Pendiente"
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              child: Text(
                  "Pendiente"
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}