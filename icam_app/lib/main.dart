import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/routes/router.dart';
import 'package:icam_app/theme.dart';
import 'package:icam_app/ui/splash_page.dart';
import 'package:flutter_config/flutter_config.dart';
import 'localization/app_localizations.dart';
import 'dart:io';
import 'package:icam_app/classes/http_overwrite.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // load all environment variables
  await FlutterConfig.loadEnvVariables();

  // override HttpClient globally: without self-signed certificate
  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());
}


//void setPermissions() async{
//  Map<PermissionGroup, PermissionStatus> permissions =
//  await PermissionHandler().requestPermissions([PermissionGroup.location]);
//}

final appTitle = 'WaterAPProval';

class MyApp extends StatefulWidget {

  // locale
  static void setLocale(BuildContext context, Locale locale){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // current locale
  Locale _locale;

  // change locale from anywhere in the app
  void setLocale(Locale locale){
    setState(() {
      print('new locale is $locale');
      _locale = locale;
    });
  }

  // get locale for the first time when launching app,
  // get locale from shared preferences and set it to _locale
  @override
  void didChangeDependencies() { // called when dependency of this State object changes.
    getLocale().then((locale) {
      setState(() {
        print('locale is $locale');
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    print(".env file ==> API_URL: " + FlutterConfig.get('API_URL'));

    // to prevent device orientation changes and force portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    if(this._locale == null) {
      return Container(
        child: Center(child: CircularProgressIndicator()),
      );
    } else {

      return MaterialApp(
        title: appTitle,   // onGenerateTitle
        theme: myTheme,
        home: SplashPage(),
        locale: _locale,
        // app’s Localizations widget only follows suit
        // if the new locale is a member of the this list.
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('es', 'CO')
        ],
        // these delegates make sure the localization data for
        // the proper language is loaded
        localizationsDelegates: [
          // class that loads the translations from JSON files
          AppLocalizations.delegate,
          // built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate,
          // built-in localization for text direction LTR/RTL
//          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        // resolves the app's locale when when the app is started,
        // and when the user changes the device's locale.
        localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
          print('device Locale is $locale');
          // check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (locale.countryCode == supportedLocale.countryCode) {
              // the app will support the language
              return supportedLocale;
            }
          }
          // if the locale of the device is not supported, use first one
          // from the list (English, in this case)
//          return locale;
          return supportedLocales.first; // default locale

        },
        // navigation using Generated Routes
        onGenerateRoute: Router.generateRoute,
        initialRoute: homeRoute,
        // disable the "debug" banner
        debugShowCheckedModeBanner: false,
      );
    }
  }
}