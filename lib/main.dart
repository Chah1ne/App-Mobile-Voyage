// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voyage/config/global.params.dart';
import 'package:voyage/pages/Pays-details.page.dart';
import 'package:voyage/pages/authentification.page.dart';
import 'package:voyage/pages/contact.page.dart';
import 'package:voyage/pages/gallerie.page.dart';
import 'package:voyage/pages/home.dart';
import 'package:voyage/pages/inscription.page.dart';
import 'package:voyage/pages/meteo.page.dart';
import 'package:voyage/pages/parametres.page.dart';
import 'package:voyage/pages/pays.page.dart';

import 'firebase_options.dart';

ThemeData theme = ThemeData.light();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await onGetMode();
  GlobalParams.themeActuel.setMode(await onGetMode());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = {
    '/home': (context) => HomePage(),
    '/inscription': (context) => InscriptionPage(),
    '/authentification': (context) => AuthPage(),
    '/meteo': (context) => MeteoPage(),
    '/pays': (context) => PaysPage(),
    '/contact': (context) => ContactPage(),
    '/parametre': (context) => MyParam(),
    '/PaysDetailsPage': (context) => PaysDetailsPage(),
    '/gallerie': (context) => GaleriePage(),
  };
  @override
  void initState() {
    super.initState();
    GlobalParams.themeActuel.addListener(() {
      setState(() {});
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: GlobalParams.themeActuel.getTheme(),
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return HomePage();
              else
                return AuthPage();
            }));
  }
}

Future<String> onGetMode() async {
  final snapshot = await ref.child('mode').get();
  if (snapshot.exists)
    mode = snapshot.value.toString();
  else
    mode = "Jour";
  print(mode);
  return (mode);
}
