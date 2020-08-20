import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:icam_app/theme.dart';

import 'home_page.dart';

// splash screen
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 4,
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