import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/main.dart';

class CartagenaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, "about")),
        ),
        body: Stack(
            children: <Widget> [
              ListView(
                  padding: const EdgeInsets.fromLTRB(
                    30.0,
                    kToolbarHeight - 40.0,
                    35.0,
                    30.0,
                  ),
                  children: <Widget> [
                    ProjectInfo(),
                    Divider(height: 40),
                  ]
              )
            ]
        )
    );
  }
}

TextStyle _textStyleTitle = TextStyle(
    fontSize: 22,
    color: Colors.black87,
    fontWeight: FontWeight.w600
);

TextStyle _textStyleContent = TextStyle(
  fontSize: 15,
  color: Colors.black87,
  height: 1.5,
);

class ProjectInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "project_info"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          SingleChildScrollView(
              child: Text(
                appTitle + " " + getTranslated(context, "project_description"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          )
        ]
    );
  }
}


