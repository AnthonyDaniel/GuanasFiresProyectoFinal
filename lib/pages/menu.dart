import 'package:flutter/material.dart';
import 'package:guanasfires/pages/app_navbar/appBars.dart';
import 'package:guanasfires/pages/bottom_navigation/bottomNavigation.dart';
import 'package:guanasfires/pages/help.dart';
import 'package:guanasfires/pages/widget/fab.dart';
import 'package:guanasfires/pages/home.dart';
import 'package:guanasfires/pages/login.dart';
import 'package:guanasfires/services/auth_services/sign_in.dart';
import 'package:guanasfires/theme/util.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Sign_In googleAuth = new Sign_In();
  final bottomNavigationBarIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullAppbar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => Container(
                        margin: EdgeInsets.only(left: 10, top: 15, bottom: 0),
                        child: Text(
                          'Menú',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.TextSubHeader),
                        ),
                      ),
                  childCount: 1),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Home();
                          },
                        ),
                      );
                    },
                    child:Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 65,
                                height: 65,
                                child: Image.asset('assets/images/fire.png'),
                                decoration: const BoxDecoration(
                                  color: CustomColors.YellowBackground,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Inicio',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: CustomColors.TextHeaderGrey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Se muestran todos los incendios',
                                style: TextStyle(
                                    fontSize: 9,
                                    color: CustomColors.TextSubHeaderGrey),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.GreyBorder,
                              blurRadius: 10.0,
                              spreadRadius: 5.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.all(10),
                        height: 150.0// handle your onTap here
                    ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          //return ();
                        },
                      ),
                    );
                  },
                  child:   Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 65,
                              height: 65,
                              child: Image.asset('assets/images/Clipboard-empty.png'),
                              decoration: const BoxDecoration(
                                color: CustomColors.GreenBackground,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Pendientes',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: CustomColors.TextHeaderGrey,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Incendios por atender',
                              style: TextStyle(
                                  fontSize: 9,
                                  color: CustomColors.TextSubHeaderGrey),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.GreyBorder,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.all(10),
                      height: 150.0
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Help();
                        },
                      ),
                    );
                  },
                  child:   Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 65,
                              height: 65,
                              child: Icon(Icons.help_outline),
                              decoration: const BoxDecoration(
                                color: CustomColors.PurpleBackground,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Ayuda',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: CustomColors.TextHeaderGrey,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Numeros de teléfono importantes',
                              style: TextStyle(
                                  fontSize: 9,
                                  color: CustomColors.TextSubHeaderGrey),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.GreyBorder,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.all(10),
                      height: 150.0
                  ),
                ),
                InkWell(
                  onTap: (){
                    showDialogSignOut();
                  },
                  child:Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 65,
                              height: 65,
                              child: Icon(Icons.input),
                              decoration: const BoxDecoration(
                                color: CustomColors.OrangeBackground,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Salir',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: CustomColors.TextHeaderGrey,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Salir de la aplicación',
                              style: TextStyle(
                                  fontSize: 9,
                                  color: CustomColors.TextSubHeaderGrey),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.GreyBorder,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.all(10),
                      height: 150.0
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context),
      bottomNavigationBar:
          BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );
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

}
