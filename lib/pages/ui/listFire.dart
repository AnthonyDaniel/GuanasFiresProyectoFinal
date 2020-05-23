
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guanasfires/pages/model/incendio.dart';
import 'package:guanasfires/pages/ui/addFire.dart';


class ListFire extends StatefulWidget{ 
   const ListFire();
  @override
  _ListFireState createState() => _ListFireState();

}
class _ListFireState extends State<ListFire>{
Widget build(BuildContext context) {
    return CupertinoPageScaffold(
   
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              child: Text(
                  "list"
              ),
              onPressed: () {
               
              },
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              child: Text(
                  "Ayuda"
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
              AddFire(Incendio(null, '', '', '', '', '', '',''))),
    );
  }
}