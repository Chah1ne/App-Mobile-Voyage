import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../menu/drawer.widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text("Utilisateur : ${user?.email}", style: TextStyle(fontSize: 22)),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _buildMenuItem(context, 'Météo', Icons.sunny, '/meteo'),
                _buildMenuItem(context, 'Galerie', Icons.photo_library, '/gallerie'),
                _buildMenuItem(context, 'Pays', Icons.flag, '/pays'),
                _buildMenuItem(context, 'Contact', Icons.contact_emergency, '/contact'),
                _buildMenuItem(context, 'Paramètres', Icons.settings, '/parametre'),
                _buildMenuItem(context, 'Déconnexion', Icons.connect_without_contact, '/authentification'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        if (route == '/authentification') {
          _Deconnexion(context);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _Deconnexion(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/authentification', (route) => false);
  }
}
