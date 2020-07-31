//import 'package:flutter/material.dart';
//
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:intl/intl.dart';
//import 'l10n/messages_all.dart';
//
//import 'dart:async';
//
//// class that encapsulates the app’s localized values.
//class AppLocalization {
//  AppLocalization(this.localeName);
//
//  static Future<AppLocalization> load(Locale locale) {
//
//    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
//    final String localeName = Intl.canonicalizedLocale(name);
//
//    // import a generated message catalog that
//    // provides the initializeMessages()
//    return initializeMessages(localeName).then((_) {
//      // default locale
//      return AppLocalization(localeName);
//    });
//  }
//
//  // access AppLocalizations anywhere in the app
//  // loading and retrieving localized values
//  static AppLocalization of(BuildContext context) {
//    return Localizations.of<AppLocalization>(context, AppLocalization);
//  }
//
//  final String localeName;
//
//  // actual content to be translated
//  String get title {
//    return Intl.message(
//      'Hello World',
//      name: 'title',
//      desc: 'Title for the Demo application',
//      locale: localeName,
//    );
//  }
//}
//
//// wrapper to access all the info in the app
//class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
//  const AppLocalizationsDelegate();
//
//  @override
//  bool isSupported(Locale locale) {
//    return ['en', 'es'].contains(locale.languageCode);
//  }
//
//  @override
//  Future<AppLocalizations> load(Locale locale) {
//    return AppLocalizations.load(locale);
//  }
//
//  @override
//  bool shouldReload(AppLocalizationsDelegate old) {
//    return false;
//  }
//}