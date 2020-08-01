
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localizations.dart';

String getTranslated(BuildContext context, String key){
  return AppLocalizations.of(context).translate(key);
}

const String LANGUAGE_CODE = "languageCode";

// language codes
const String ENGLISH = "en";
const String SPANISH = "es";

// persist language
// save user selected language inside the shared preferences
Future<Locale> setLocale(String languageCode) async {
  print("setLocale languageCode: $languageCode");
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

// get stored language inside shared preferences
Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  // if called for the first time, return default language
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
  print("getLocale languageCode: $languageCode");
  return _locale(languageCode);
}

// return Locale corresponding to a given languageCode
Locale _locale(String languageCode){
  Locale _temp;
  switch(languageCode){
    case SPANISH:
      _temp = Locale(languageCode, 'CO');
      break;
    case ENGLISH:
      _temp = Locale(languageCode, 'US');
      break;
    default:
      _temp = Locale(ENGLISH, 'US');
  }
  print("_temp $_temp");
  return _temp;
}


