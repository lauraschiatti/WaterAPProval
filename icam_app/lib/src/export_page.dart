import 'package:flutter/material.dart';

import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/theme.dart';

class ExportControllerPage extends StatefulWidget {
  ExportControllerPage({Key key}) : super(key: key);

  @override
  ExportControllerPageState createState() => ExportControllerPageState();
}


class ExportControllerPageState extends State<ExportControllerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Text("Export data"),

//                    ProjectInfo(),
//                    Divider(height: 40),
                  ]
              )
            ]
        )
    );
  }

}
