// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class InscriptionPage extends StatelessWidget {
  InscriptionPage({super.key});
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_pwd = new TextEditingController();
  late SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Page Inscription'),
          backgroundColor: Color.fromARGB(255, 30, 49, 177)),
      body: Column(
        children: [
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
                controller: txt_pwd,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.key_rounded,
                      color: Color.fromARGB(255, 30, 49, 177),
                    ),
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
                  _onInscrire(context);
                },
                child: Text('Inscription', style: TextStyle(fontSize: 22))),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/authentification');
              },
              child: Text("J'ai déjà un compte",
                  style: TextStyle(
                      fontSize: 22, color: Color.fromARGB(255, 30, 49, 177))))
        ],
      ),
    );
  }

  Future<void> _onInscrire(BuildContext context) async {
    if (!txt_login.text.isEmpty && !txt_pwd.text.isEmpty) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: txt_login.text.trim(), password: txt_pwd.text.trim());
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        SnackBar sb = SnackBar(content: Text(""));
        if (e.code == 'weak-password') {
          sb = SnackBar(content: Text("Mot de passe faible"));
        } else if (e.code == "email-already-in-use") {
          sb = SnackBar(content: Text("Email déjà existant"));
        }
        ScaffoldMessenger.of(context).showSnackBar(sb);
      }
    } else {
      const sb = SnackBar(content: Text("Id ou mot de passe vides"));
      ScaffoldMessenger.of(context).showSnackBar(sb);
    }
  }
}
