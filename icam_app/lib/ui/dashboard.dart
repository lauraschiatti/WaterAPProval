import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/routes/route_names.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage();

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
            getTranslated(context, "dashboard"),
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
                    getTranslated(context, "available_wb"),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text("6"),
                ),
              ),
              Divider(),
              Expanded(
                child: ListTile(
                  title: Text(
                    getTranslated(context, "available_nodes"),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text("8"),
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
                        color: Colors.red[700],
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
                            getTranslated(context, "recently_collected"),
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
                        color: Colors.green,
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
                            getTranslated(context, "icam_chart"),
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
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        nodesShowRoute,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.blue,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 40
                          ),
                          Text(
                            getTranslated(context, "available_nodes"),
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
            ],
          ),
        ),
      ],
    ),
  );
}
