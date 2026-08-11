import "package:flutter/material.dart";
import "../localization/app_string.dart";

class LanguageProvider extends ChangeNotifier{ 
  String _currentLang= "en";
  String get currentLang => _currentLang;

  void changelang(String lang){
    _currentLang= lang;
    notifyListeners();
  }

  String text(String key){
    return AppStrings.value[_currentLang]?[key]?? key;
  }

}