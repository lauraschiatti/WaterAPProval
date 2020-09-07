
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/theme.dart';
import 'package:icam_app/services/water_body_service.dart';

class ExploreDataPage extends StatefulWidget {
  ExploreDataPage();

  @override
  ExploreDataPageState createState() => ExploreDataPageState();
}


class ExploreDataPageState extends State<ExploreDataPage> {

  Future _futureWaterBodies;

  @override
  void initState() {
    super.initState();

    _futureWaterBodies = fetchWaterBodies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(getTranslated(context, "available_wb"))
      ),
      body:
        Container(
          padding: EdgeInsets.fromLTRB(6, 10, 6, 10),
          child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//                Padding(
//                  child: Text(
//                    getTranslated(context, "recently_collected"),
//                    style: TextStyle(
//                        fontSize: 18,
//                        color: Colors.black87,
//                        fontWeight: FontWeight.w600
//                    ),
//                    textAlign: TextAlign.left,
//                  ),
//                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
//                ),
                Expanded(
                  child: FutureBuilder(
                    future: _futureWaterBodies,
                    builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                    children = <Widget>[
//                      Icon(
//                        Icons.error_outline,
//                        color: Colors.red,
//                        size: 60,
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(top: 16),
//                        child: Text('Error: ${snapshot.error}'),
//                      )
//                    ];
//                  }


                      if (!snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return Container(
                            padding: EdgeInsets.all(14),
                            child: Text("No water bodies available")
                        );
                      }

                      if (snapshot.hasData) {

                        var waterBodies = snapshot.data.data;

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: waterBodies.length,
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          itemBuilder: (BuildContext cnt, int index) {
                            var waterBody = waterBodies[index];

                            return Card(
                              child: ListTile(
                                  leading: Icon(
                                      Icons.brightness_1,
                                      size: 30.0,
                                      color: myTheme.primaryColor
                                  ),
                                  title: Text('${waterBody.name}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    color: Colors.black38,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context,
                                          waterBodyDataPageRoute,
                                          arguments: waterBody
                                      );

                                    },
                                  )
                              ),

                            );
                          },

                        );
                      }

                      return Center(
                        child: Container(
                          child: new CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                )
              ]
          )
      )
    );
  }
}
