
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/theme.dart';
import 'package:icam_app/models/datum.dart';
import 'package:icam_app/services/datum_service.dart';
import 'package:icam_app/services/water_body_service.dart';
import 'package:icam_app/services/node_service.dart';
import 'package:icam_app/classes/echarts_theme_script.dart' show customThemeScript;
import 'package:icam_app/classes/chart_classes.dart';
import 'package:icam_app/classes/utils.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage();

  final Key _chartKey = UniqueKey();

  @override
  DashboardPageState createState() => DashboardPageState();
}


class DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 10, 6, 10),
      child: Column(
        children: <Widget>[
          _buildBody(context),
        ]
      )
    );
  }
}


Widget _buildBody(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        _buildHeader(),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Dashboard",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
        ),
        Card(
          elevation: 4.0,
          color: Colors.white,
          margin: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(
                    "Water bodies",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text("6"),
                  trailing: Icon(Icons.map),
                ),
              ),
              VerticalDivider(),

              Expanded(
                child: ListTile(
                  title: Text(
                    "Monitoring points (nodes)",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text("8"),
                  trailing: Icon(Icons.location_on),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        exploreRoute,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.green,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.assignment,
                            color: Colors.white,
                            size: 40
                          ),
                          Text(
                            "recently collected data",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    )
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildTile(
                  color: Colors.pink,
                  icon: Icons.portrait,
                  title: "Dropped",

                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        exportRoute,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.pink,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.insert_chart,
                            color: Colors.white,
                            size: 40
                          ),
                          Text(
                            "ICAMpff chart",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    )
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildTile(
                  color: Colors.blue,
                  icon: Icons.portrait,
                  title: "Admitted",

                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    ),
  );
}

_buildTile({Color color, IconData icon, String title}) {
  return GestureDetector(
      onTap: (){
        print("Container clicked");
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white
              ),
            )
          ],
        ),
      )
  );
}



