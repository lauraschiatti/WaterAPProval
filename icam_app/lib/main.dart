import 'package:flutter/material.dart';

import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/routes/router.dart';

import 'package:splashscreen/splashscreen.dart';
import 'package:icam_app/theme.dart';

import 'src/home_page.dart';

void main() => runApp(MyApp());

final appTitle = 'ICAM App';

class MyApp extends StatelessWidget {

  // this widget is the root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  //        onGenerateTitle
        title: appTitle,
        theme: myTheme,
        home: SplashPage(),

        // navigation using Generated Routes
        onGenerateRoute: Router.generateRoute,
        initialRoute: homeRoute,

         // disable the "debug" banner
        debugShowCheckedModeBanner: false,

    );
  }
}


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      backgroundColor: myTheme.primaryColor,
      title: Text(
        'ICAM App ',
        style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20.0,
            color: Colors.white
        ),
      ),
      image: Image.asset('assets/images/icon.png',
          fit: BoxFit.cover,
//          height: 100.0,
//          width: 100.0
      ),
      photoSize: 90.0,
      loaderColor: Colors.white,
      styleTextUnderTheLoader: TextStyle(),
      navigateAfterSeconds:  HomePage(),
    );
  }
}