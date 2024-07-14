// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:voyage/config/global.params.dart';

String mode = "Jour";
FirebaseDatabase fire = FirebaseDatabase.instance;
DatabaseReference ref = fire.ref();

class MyParam extends StatefulWidget {
  const MyParam({super.key});

  @override
  State<MyParam> createState() => _MyParamState();
}

class _MyParamState extends State<MyParam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parametres")),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text('Mode', style: Theme.of(context).textTheme.displaySmall),
        Column(
          children: <Widget>[
            ListTile(
                title: const Text('Jour'),
                leading: Radio<String>(
                  value: 'Jour',
                  groupValue: mode,
                  onChanged: (value) {
                    setState(() {
                      mode = value!;
                    });
                  },
                )),
            ListTile(
                title: const Text('Nuit'),
                leading: Radio<String>(
                  value: 'Nuit',
                  groupValue: mode,
                  onChanged: (value) {
                    setState(() {
                      mode = value!;
                    });
                  },
                )),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              child: Text(
                'Enregistrer',
                style: TextStyle(fontSize: 22),
              ),
              onPressed: () {
                _onSaveMode();
              }),
        )
      ]),
    );
  }

  _onSaveMode() async {
    GlobalParams.themeActuel.setMode (mode) ; 
    await ref.set({"mode": mode});
    print("mode changé");
    Navigator.pop(context);
  }
}
