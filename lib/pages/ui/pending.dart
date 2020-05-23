
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guanasfires/pages/model/incendio.dart';


import 'addFire.dart';

class Pending extends StatelessWidget {
  const Pending();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
   
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
              onPressed: () {
                _createNewProduct(context);
              },
            ),
          ],
        ),
      ),
    );
  }
   void _createNewProduct(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              AddFire(Incendio(null,'','','','','','',''))),
    );
  }
}