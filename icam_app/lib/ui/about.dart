import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:get_version/get_version.dart';

import 'package:icam_app/main.dart';
import 'package:icam_app/theme.dart';

class AboutPage extends StatefulWidget {

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _projectVersion = '';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _projectVersion = projectVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myTheme.primaryColor,
//        appBar: AppBar(
//          title: Text(getTranslated(context, "info_app")),
//        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                appTitle,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 15),
              Text(
                getTranslated(context, 'version') + " " + _projectVersion,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: Colors.blue[50]
                ),
              ),
              SizedBox(height: 24),
              Image.asset('assets/icon/water-icon.png',
                  height: 100.0,
                  width: 100.0
              ),
              SizedBox(height: 20),
              Text(
                "© 2020",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16.0,
                    color: Colors.blue[50]
                ),
              ),
            ],
          ),
        )
    );

  }
}