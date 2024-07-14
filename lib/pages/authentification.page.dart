// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_pwd = new TextEditingController();
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Page Authenficiation', style: TextStyle(color: Colors.white),),
            backgroundColor: Color.fromARGB(255, 30, 49, 177)),
        body: Column(children: [
          Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: txt_login,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person,
                        color: Color.fromARGB(255, 30, 49, 177)),
                    hintText: "Utilisateur",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10))),
              )),
          Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                obscureText: true,
                controller: txt_pwd,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.key,
                        color: Color.fromARGB(255, 30, 49, 177)),
                    hintText: "Mot de passe",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10))),
              )),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Color.fromARGB(255, 30, 49, 177)),
              onPressed: () {
                _onAuthentifier(context);
              },
              child: Text('Connexion', style: TextStyle(fontSize: 22,color: Colors.white)),
            ),
          ),
          TextButton(
              child: Text('Nouvel Utilisateur',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromARGB(255, 30, 49, 177))),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/inscription');
              })
        ]));
  }

  Future<void> _onAuthentifier(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: txt_login.text.trim(), password: txt_pwd.text.trim());
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      SnackBar snackBar = SnackBar(content: Text(""));
      if (e.code == 'user-not-found')
        snackBar = SnackBar(content: Text('Utilisateur inexistant'));
      else if (e.code == 'wrong-password')
        snackBar = SnackBar(content: Text('Verifier votre mot de passe'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
