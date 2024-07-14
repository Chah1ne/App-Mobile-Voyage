import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MeteoDetailsPage extends StatefulWidget {
  final String ville;
  MeteoDetailsPage(this.ville);

  @override
  State<MeteoDetailsPage> createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  var meteoData;

  @override
  void initState() {
    super.initState();
    getMeteoData(widget.ville);
  }

  void getMeteoData(String ville) {
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=${ville}&appid=0e97a0ad3cd39f529ec4daafc0f87679";
    http.get(Uri.parse(url)).then((value) {
      setState(() {
        this.meteoData = json.decode(value.body);
        print(this.meteoData);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Meteo Details'),
        backgroundColor: Colors.indigo,
      ),
      body: meteoData ==null?
      Center(
        child: CircularProgressIndicator(),
      ):

      ListView.builder(
        itemCount: (meteoData == null ? 0 : meteoData['list'].length),
        itemBuilder: (context, index) {
          var item = meteoData['list'][index];
          var date = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
          var heureEtEtat = item['weather'][0]['description'];
          var temperature = item['main']['temp'];

          return Card(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "images/${item['weather'][0]['main'].toString().toLowerCase()}.png",
                        ),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('EEEE, MMMM d, y').format(date),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt'] * 1000000))} ${meteoData['list'][index]['weather'][0]['description']}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Température: ${(item['main']['temp'] - 273.15).toStringAsFixed(1)}°C",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
