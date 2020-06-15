
import 'package:flutter/material.dart';
import 'package:guanasfires/pages/app_navbar/appBars.dart';
import 'package:guanasfires/pages/bottom_navigation/bottomNavigation.dart';
import 'package:guanasfires/pages/widget/fab.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget{
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {

  final bottomNavigationBarIndex = 0;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: fullAppbar(context),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(bottom: 8.0)),
          Text('BOMBEROS DE COSTA RICA',
            style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.green
                ),
                 textAlign: TextAlign.center,
          ),
         
          new  ListTile(
          title: Text("BAGACES"), 
          subtitle: Text("26711043"),
          trailing: Icon(Icons.phone),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Image.asset('assets/images/emergency.png'),
          ),
          onTap: (){customLaunch('tel:26711043');}
        ),
        Divider(),
          new  ListTile(
          title: Text("LIBERIA"), 
          subtitle: Text("26660279"),
          trailing: Icon(Icons.phone),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Image.asset('assets/images/emergency.png'),
          ),
         onTap: (){customLaunch('tel:26660279');}
        ),
        Divider(),
          new  ListTile(
          title: Text("ABANGARES"), 
          subtitle: Text("26620185"),
          trailing: Icon(Icons.phone),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Image.asset('assets/images/emergency.png'),
          ),
         onTap: (){customLaunch('tel:26620185');}
        ),
        Divider(),
          new  ListTile(
          title: Text("CAÑAS"), 
          subtitle: Text("26690072"),
          trailing: Icon(Icons.phone),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Image.asset('assets/images/emergency.png'),
          ),
         onTap: (){customLaunch('tel:26690072');}
        ),
        Divider(),
          new  ListTile(
          title: Text("SANTA CRUZ"), 
          subtitle: Text("26800090"),
          trailing: Icon(Icons.phone),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Image.asset('assets/images/emergency.png'),
          ),
         onTap: (){customLaunch('tel:26800090');}
        ),
        Divider(),
          new  ListTile(
          title: Text("NICOYA"), 
          subtitle: Text("26855147"),
          trailing: Icon(Icons.phone
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Image.asset('assets/images/emergency.png'),
          ),
         onTap: (){customLaunch('tel:26855147');}
        ),
        Divider(),
          new  ListTile(
          title: Text("TILARAN"), 
          subtitle: Text("26958475"),
          trailing: Icon(Icons.phone
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Image.asset('assets/images/emergency.png'),
          ),
         onTap: (){customLaunch('tel:26958475');}
        ),
        Divider(),
          new  ListTile(
          title: Text("FILADELFIA"), 
          subtitle: Text("26888733"),
          trailing: Icon(Icons.phone
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Image.asset('assets/images/emergency.png'),
          ),
         onTap: (){customLaunch('tel:26888733');}
        ),
        Divider(),
          new  ListTile(
          title: Text("LA CRUZ"), 
          subtitle: Text("26799263"),
          trailing: Icon(Icons.phone),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Image.asset('assets/images/emergency.png'),
          ),
         onTap: (){customLaunch('tel:26799263');}
        ),
      ],
      ),
    
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context),
      bottomNavigationBar: BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );
  }

  void customLaunch(comand) async{
    if(await canLaunch(comand)){
      await launch(comand);
    }else{
      print("could not launch $comand");
    }
  }
  
}