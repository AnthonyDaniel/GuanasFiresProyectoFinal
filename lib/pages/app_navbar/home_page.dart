import 'package:flutter/material.dart';
import 'package:guanasfires/pages/model/incendio.dart';
import 'package:guanasfires/pages/ui/help.dart';
import 'package:guanasfires/pages/ui/home.dart';
import 'package:guanasfires/pages/ui/listFire.dart';
import 'package:guanasfires/pages/ui/login_page.dart';
import 'package:guanasfires/pages/ui/pending.dart';
import 'package:guanasfires/pages/ui/profile.dart';

import 'package:guanasfires/pages/widget/top_container.dart';
import 'package:guanasfires/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import '../../services/auth_services/sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _Navbar createState() => _Navbar();
}

class _Navbar extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Widget> index = [
    Home(),ListFire(),Pending(),Profile(),Help()
  ];
  List<_NavigationIconView> _navigationViews;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigationViews = <_NavigationIconView>[
      _NavigationIconView(
        icon: const Icon(Icons.home),
        title: "Inicio",
        vsync: this,
      ),
      _NavigationIconView(
        icon: const Icon(Icons.add_circle),
        title: "Reportar",
        vsync: this,
      ),
      _NavigationIconView(
        icon: const Icon(Icons.notifications),
        title: "Pendientes",
        vsync: this,
      ),
      _NavigationIconView(
        icon: const Icon(Icons.person_pin),
        title: "Perfil",
        vsync: this,
      ),
      _NavigationIconView(
        icon: const Icon(Icons.add_call),
        title: "Ayuda",
        vsync: this,
      ),
    ];
    _navigationViews[_currentIndex].controller.value = 1;
  }

  @override
  void dispose() {
    for (final view in _navigationViews) {
      view.controller.dispose();
    }
    super.dispose();
  }

  Widget _buildTransitionsStack() {
    return index[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    var bottomNavigationBarItems = _navigationViews
        .map<BottomNavigationBarItem>((navigationView) => navigationView.item)
        .toList();

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 70,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircularPercentIndicator(
                          radius: 60.0,
                          lineWidth: 3.0,
                          animation: true,
                          percent: 1,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: LightColors.kRed,
                          backgroundColor: LightColors.kDarkYellow,
                          center: CircleAvatar(
                            backgroundColor: LightColors.kBlue,
                            radius: 25.0,
                            backgroundImage: NetworkImage(
                              imageUrl,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: (Icon(Icons.input,color: LightColors.kDarkBlue, size: 30.0)),
                          onPressed: () {
                            _showDialogSignOut();
                          },
                        ),
                      ],
                    ),
                  ]),
            ),
            _buildTransitionsStack(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigationBarItems,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: textTheme.caption.fontSize,
        unselectedFontSize: textTheme.caption.fontSize,
        onTap: (index) {
          setState(() {
            _navigationViews[_currentIndex].controller.reverse();
            _currentIndex = index;
            _navigationViews[_currentIndex].controller.forward();
          });
        },
        selectedItemColor: LightColors.kDarkBlue,
        unselectedItemColor: LightColors.kDarkBlue.withOpacity(0.40),
        backgroundColor: LightColors.kLightYellow
      ),
    );
  }
  void _showDialogSignOut() {
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
                signOutGoogle();
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

class _NavigationIconView {
  _NavigationIconView({
    this.title,
    this.icon,
    TickerProvider vsync,
  })  : item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
        ),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final String title;
  final Widget icon;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;
}





