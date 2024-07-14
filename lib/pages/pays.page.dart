import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaysPage extends StatefulWidget {
  const PaysPage();

  @override
  _PaysPageState createState() => _PaysPageState();
}

class _PaysPageState extends State<PaysPage> {
  final TextEditingController _paysController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Pays'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _paysController,
              decoration: const InputDecoration(labelText: 'Pays',prefixIcon: Icon(Icons.flag)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onGetPaysDetails();
              },
              child: const Text('Chercher'),
            ),
          ],
        ),
      ),
    );
  }

  void onGetPaysDetails() async {
    final paysSaisi = _paysController.text;
    if (paysSaisi.isNotEmpty) {
      Navigator.pushNamed(context, '/PaysDetailsPage', arguments: paysSaisi);
    }
  }
}
