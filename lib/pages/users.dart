import 'package:flutter/material.dart';
import 'package:guanasfires/pages/bottom_navigation/bottomNavigation.dart';
import 'package:guanasfires/pages/widget/fab.dart';
import 'package:guanasfires/services/auth_services/sign_in.dart';

import 'app_navbar/appBars.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  Sign_In uServ= new Sign_In();
  final bottomNavigationBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullAppbar(context),
      body: Column(
        children: <Widget>[
           Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Text('USUARIOS REGISTRADOS',
            style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.green
                ),
                 textAlign: TextAlign.center,
          ),
          showTodoList(),
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context),
      bottomNavigationBar:
          BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );
  }

  Widget showTodoList() {
    if (usersList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: usersList.length,
          itemBuilder: (BuildContext context, int index) {
            String todoId = usersList[index].key;
            String subject = usersList[index].email;
            bool completed = usersList[index].admin;
            String userId = usersList[index].userId;
            String imagenUrl = usersList[index].imageUrl;
            return Dismissible(
              key: Key(todoId),
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                uServ.deleteTodo(todoId, index);
              },
              child: ListTile(
                title: Text(
                  subject,
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: IconButton(
                    icon: (completed)
                        ? Icon(
                            Icons.done_outline,
                            color: Colors.green,
                            size: 20.0,
                          )
                        : Icon(Icons.done, color: Colors.grey, size: 20.0),
                    onPressed: () {
                        //updateTodo(_usersList[index]);
                    }),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    imagenUrl,
                  ),
                ),
              ),
             
            );
           
          });
    }
  }
}
