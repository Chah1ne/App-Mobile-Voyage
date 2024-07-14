import 'package:flutter/material.dart';

import 'meteo-details.page.dart';

class MeteoPage extends StatelessWidget {
  final TextEditingController _villeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Météo')),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _villeController,
              decoration: InputDecoration(labelText: 'Ville',prefixIcon: Icon(Icons.location_city)),
              onChanged: (value) {},
            ),
            ElevatedButton(
              onPressed: () {
                onGetMeteoDetails(context);
              },
              child: Text('Rechercher'),
            ),
          ],
        ),
      ),
    );
  }


  void onGetMeteoDetails(BuildContext context) {
    String v = _villeController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeteoDetailsPage(v),
      ),
    );
    _villeController.clear(); // Pour effacer le texte après la recherche
  }


}