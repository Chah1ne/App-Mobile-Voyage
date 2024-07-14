import 'package:flutter/material.dart';
class MonTheme extends ChangeNotifier{
static String mode="Jour";
void setMode(String m){
mode=m;
notifyListeners();
}
ThemeData getTheme(){
return (mode=="Jour")? ThemeData.light():ThemeData.dark();
}
}