import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaysDetailsPage extends StatefulWidget {
  const PaysDetailsPage();

  @override
  _PaysDetailsPageState createState() => _PaysDetailsPageState();
}

class _PaysDetailsPageState extends State<PaysDetailsPage> {
  Map<String, dynamic>? paysDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getPaysData(ModalRoute.of(context)!.settings.arguments as String);
  }

  void getPaysData(String pays) async {
    final response = await http.get(Uri.parse('https://restcountries.com/v2/name/$pays'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        paysDetails = decodedData[0];
      });
      print(paysDetails);
    } else {
      print('Échec de la requête');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paysDetails?['name'] ?? 'Page Pays Details'),
      ),
      body: paysDetails != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(paysDetails?['flags']['png'] ?? '')),
            const SizedBox(height: 25),
            Text('${paysDetails?['name'] ?? ''}'),
            const SizedBox(height: 15),
            Text('${paysDetails?['nativeName'] ?? ''}'),


            const SizedBox(height: 35),
            Text('Administration' , style: TextStyle(color: Colors.blue)),
            Text('Capitale: ${paysDetails?['capital'] ?? ''}'),
            Text('Language(s): ${paysDetails?['languages'][0]['name'] ?? ''}'),
            const SizedBox(height: 20),
            Text('Géographie', style: TextStyle(color: Colors.blue)),
            Text('Région: ${paysDetails?['region'] ?? ''}'),
            Text('Superficie: ${paysDetails?['area'] ?? ''}'),
            Text('Fuseau Horaire: ${paysDetails?['timezones'][0] ?? ''}'),
            const SizedBox(height: 20),
            Text('Démographie', style: TextStyle(color: Colors.blue)),
            Text('Population: ${paysDetails?['population'] ?? ''}'),
          ],
        ),
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
