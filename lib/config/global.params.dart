import 'package:flutter/material.dart';
import 'package:voyage/notifier/theme.dart';

class GlobalParams {
  static MonTheme themeActuel=MonTheme(); 

  static List<Map<String, dynamic>> menus = [
    {
      "title": "Accueil",
      "icon": Icon(Icons.home, color: Colors.blueAccent[200]),
      "route": "/home"
    },
    {
      "title": "Meteo",
      "icon": Icon(Icons.sunny_snowing, color: Colors.blueAccent[200]),
      "route": "/meteo"
    },
    {
      "title": "Gallerie",
      "icon": Icon(Icons.photo, color: Colors.blueAccent[200]),
      "route": "/gallerie"
    },
    {
      "title": "Pays",
      "icon": Icon(Icons.location_city, color: Colors.blueAccent[200]),
      "route": "/pays"
    },
    {
      "title": "Contact",
      "icon": Icon(Icons.contact_page, color: Colors.blueAccent[200]),
      "route": "/contact"
    },
    {
      "title": "Parametres",
      "icon": Icon(Icons.settings, color: Colors.blueAccent[200]),
      "route": "/parametre"
    },
    {
      "title": "Deconnexion",
      "icon": Icon(Icons.logout, color: Colors.blueAccent[200]),
      "route": "/authentification"
    },
  ];
  static List<Map<String, dynamic>> accueil = [
    {"image": "images/sun.png", "route": "/meteo"},
    {"image": "images/picture.png", "route": "/gallerie"},
    {"image": "images/pays.png", "route": "/pays"},
    {"image": "images/add-user.png", "route": "/contact"},
    {"image": "images/settings.png", "route": "/parametres"},
    {"image": "images/logout.png", "route": "/authentification"},
  ];
}
