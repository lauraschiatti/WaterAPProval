import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icam_app/models/datum.dart';
import 'package:icam_app/models/water_body.dart';
import 'package:icam_app/theme.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/services/datum_service.dart';
import 'package:icam_app/classes/utils.dart';

class WaterBodyDataPage extends StatefulWidget {

  final WaterBodyData waterbody;
  WaterBodyDataPage(this.waterbody);

  @override
  _WaterBodyDataPagePageState createState() => _WaterBodyDataPagePageState();

}

class _WaterBodyDataPagePageState extends State<WaterBodyDataPage> {

  Future _futureData;

  @override
  initState() {
    super.initState();

    var mp = widget.waterbody.puntosDeMonitoreo;
    final string = json.encode(mp);

    print("puntosDeMonitoreo: $mp");

    var additionalFilters = '[{"trackedObject": {"inq": $string}}]';
    _futureData = fetchData(additionalFilters);

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: new AppBar(
          title: Text('${widget.waterbody.name}'),
        ),
        body: FutureBuilder(
            future: _futureData,
            builder: (context, snapshot) {
              //  if (snapshot.hasError) {
////           if (snapshot.hasError) {
//              children = <Widget>[
//                Icon(
//                  Icons.error_outline,
//                  color: Colors.red,
//                  size: 60,
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(top: 16),
//                  child: Text('Error: ${snapshot.error}'),
//                )
//              ];
//            }

              if (!snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return Container(
                    padding: EdgeInsets.all(14),
                    child: Text("No data available for ${widget.waterbody.name}")
                );
              }

              if (snapshot.hasData) {

                var data = snapshot.data;
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                              getTranslated(context, "recently_collected_data"),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: myTheme.primaryColor,
                              ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      SizedBox(height: 20),
                      _buildListBuilder(data)
                    ],
                  ),
                );
              }

              // By default, show a loading spinner.
              return Center(
                child: Container(
                  child: new CircularProgressIndicator(),
                ),
              );
            }
        )
    );
  }


  _buildListBuilder(data) {
    if (data.isEmpty) {
      return Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Text("No data available",
              style: TextStyle(
                  fontWeight: FontWeight.w400
              ),
            ),
          )
      );
    } else {

      return Expanded(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              Datum datum = data.elementAt(index);

              return Card(
//                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.assignment),
                      // convert timestamp in milliseconds to a dateTime format
                      title: Text("Date: ${readTimestamp(datum.date)[0]}"),
                      subtitle: Text(
                        '${readTimestamp(datum.date)[1]}',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    listItem(context, "ICAMpff", datum.icampff),
                    listItem(context, getTranslated(context, "dissolved_oxygen"), datum.dissolvedOxygen),
                    listItem(context, getTranslated(context, "nitrate"), datum.nitrate),
                    listItem(context, getTranslated(context, "total_suspended_solids"), datum.totalSuspendedSolids),
                    listItem(context, getTranslated(context, "thermotolerant_coliforms"), datum.thermotolerantColiforms),
                    listItem(context, "pH", datum.pH),
                    listItem(context, getTranslated(context, "chrolophyll_a"), datum.chrolophyllA),
                    listItem(context, getTranslated(context, "biochemical_oxygen_demand"), datum.biochemicalOxygenDemand),
                    listItem(context, getTranslated(context, "phosphates"), datum.phosphates),
                    SizedBox(height: 20,)

//                    ButtonBar(
//                      alignment: MainAxisAlignment.start,
//                      children: [
//                        FlatButton(
//                          textColor: const Color(0xFF6200EE),
//                          onPressed: () {
//                            // Perform some action
//                          },
//                          child: const Text('ACTION 1'),
//                        ),
//                        FlatButton(
//                          textColor: const Color(0xFF6200EE),
//                          onPressed: () {
//                            // Perform some action
//                          },
//                          child: const Text('ACTION 2'),
//                        ),
//                      ],
//                    ),
//                    Image.asset('assets/card-sample-image.jpg'),
//                    Image.asset('assets/card-sample-image-2.jpg'),
                  ],
                ),
              );
            }
        ),
      );
    }
  }

  // parameter value Item
  Widget listItem(context, String title, double value) {

    String val;

    if(value == -1){
      val = '-';
    } else {
      val = value.toString();
    }

    return new Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
      child: RichText(
        text: TextSpan(
          text: '$title: ',
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
                text: val,
                style: TextStyle(color: Colors.black.withOpacity(0.6))
            ),
          ],
        ),
      ),
    );
  }

}