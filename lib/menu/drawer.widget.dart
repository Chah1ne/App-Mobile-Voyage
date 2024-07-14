// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/global.params.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  late SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        const DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.white,
              Color.fromARGB(255, 7, 74, 161)
            ])),
            child: Center(
                child: CircleAvatar(
              backgroundImage: AssetImage("images/chahine.jpg"),
              radius: 80,
            ))),
        ...(GlobalParams.menus as List).map((item) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  '${item['title']}',
                  style: TextStyle(fontSize: 22),
                ),
                leading: item['icon'],
                trailing: Icon(
                  Icons.arrow_right,
                  color: Colors.blueAccent[200],
                ),
                onTap: () async {
                  if ('${item['title']}' != "Deconnexion") {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "${item['route']}");
                  } else {
                   FirebaseAuth.instance.signOut(); 
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/authentification", (route) => false);
                  }
                },
              ),
              Divider(height: 4, color: Colors.black26)
            ],
          );
        })
      ],
    ));
  }
}
