import 'package:flutter/material.dart';
import 'package:guanasfires/pages/app_navbar/appBars.dart';
import 'package:guanasfires/pages/bottom_navigation/bottomNavigation.dart';
import 'package:guanasfires/pages/widget/fab.dart';
import 'package:guanasfires/services/auth_services/sign_in.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bottomNavigationBarIndex = 0;
  Sign_In googleAuth = new Sign_In();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullAppbar(context),
      body: Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context),
      bottomNavigationBar:
          BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );
  }
}
