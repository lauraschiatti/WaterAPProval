import 'package:flutter/material.dart';
import 'package:icam_app/main.dart';
import 'package:icam_app/routes/route_names.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Container(
        child: MaterialButton(
          color: Colors.blue,
          child: Text('Navigate to not_found page'),
          onPressed: () {
            Navigator.pushNamed(context, notFoundRoute);
          },
        ),
      ),
    );
  }
}