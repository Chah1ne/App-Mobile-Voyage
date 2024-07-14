import 'package:flutter/material.dart';

import '../menu/drawer.widget.dart';
import 'gallerie-details.page.dart';

class GaleriePage extends StatelessWidget {
  final TextEditingController _GallerieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallerie')),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _GallerieController,
              decoration: InputDecoration(labelText: 'Gallerie',prefixIcon: Icon(Icons.photo_library)),
              onChanged: (value) {},
            ),
            ElevatedButton(
              onPressed: () {
                onGetGallerieDetails(context);
              },
              child: Text('Rechercher'),
            ),
          ],
        ),
      ),
    );
  }


  void onGetGallerieDetails(BuildContext context) {
    String g = _GallerieController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GallerieDetailsPage(g),
      ),
    );
    _GallerieController.clear(); // Pour effacer le texte après la recherche
  }

}
