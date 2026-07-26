import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode =>_themeMode;

  bool get isDarkMode =>_themeMode == ThemeMode.dark;

  void changeThemeMode(bool isdark){
    _themeMode = isdark? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleThemeMode(){
    _themeMode=
     _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
  
}