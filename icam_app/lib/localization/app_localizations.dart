import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // helper method to keep the code in the widgets concise
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String> _localizedStrings;

  // load languaje JSON from "lib/lang" folder
  Future load() async {
    String jsonString =
        await rootBundle.loadString('lib/lang/${locale.languageCode}.json');

    // convert the returned string into actual JSON format
    Map<String, dynamic> mappedJson = json.decode(jsonString);

    //TODO: handle badly formatted JSON exception
    //print(mappedJson);

    // save map of string on _localizedValues
    _localizedStrings = mappedJson.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  // will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }

  // static AppLocalization to have a simple access to the delegate from
  // the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
}

// LocalizationDelegate private class to load locale value based on selected language
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {

  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // include all supported language codes
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async{
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localization = new AppLocalizations(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}