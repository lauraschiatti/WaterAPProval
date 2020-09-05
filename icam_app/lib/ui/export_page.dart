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

class ExportControllerPage extends StatefulWidget {
  ExportControllerPage();//{Key key}) : super(key: key);

  final Key _chartKey = UniqueKey();

  @override
  ExportControllerPageState createState() => ExportControllerPageState();
}


class ExportControllerPageState extends State<ExportControllerPage> {

  Future _futureWaterBodies;

  @override
  void initState() {
    super.initState();

    _futureWaterBodies = fetchWaterBodies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    _buildChart(){
      return SingleChildScrollView(
          child: Center(
              child: Column(
                  children: <Widget>[
                    Padding(
                      child: Text(
                          'Explore data',
                          style: TextStyle(
                              fontSize: 20
                          )
                      ),
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                    ),

                    Text('- data will be fetched in a few seconds'),
                    Text('- tap the bar and trigger the snack'),

                    SizedBox(height: 50),
                    SizedBox(
                        width: 380,
                        height: 400,
                        child: FittedBox(child: Chart(key:widget._chartKey))
                    ),

                    SizedBox(height: 50),
                  ]
              )
          )
      );
    }

    _buildDataList(){
      return Container(
          padding: EdgeInsets.fromLTRB(6, 10, 6, 10),
          child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  child: Text(
                    'Available water bodies',
                    style: TextStyle(
//                          fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                ),
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
                                leading: const Icon(Icons.brightness_1,
                                    size: 30.0, color: Colors.black12),
                                title: Text('${waterBody.name}'),
//                                TODO: subtitle: Text(
//                                  "Icampff: ${waterBody.icampff.toString()}",
//                                ),
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
      );

    }


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new AppBar(
          toolbarHeight: 80,
          flexibleSpace: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              new TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.insert_chart), text: "Data visualization",),
                  Tab(icon: Icon(Icons.storage), text: "Explore data"),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildChart(),
            _buildDataList()
          ],
        ),
      ),
    );
  }
}


class Chart extends StatefulWidget {
  ///key is required, otherwise map crashes on hot reload
  Chart({ @required Key key}) : super(key:key);

  @override
  _ChartState createState() => _ChartState();
}


class _ChartState extends State<Chart> {

  var _waterBodies;
  var _wqMonitoringPoints;
  List<ChartAxis> _yAxisList = [];
  var _data;
  var _icampffDates = [];
  Map<String, Map<int, double>> _icampffs = {};

  List<Unit> _units = [
    new Unit('icampff', ''),
    new Unit('dissolvedOxygen', 'mg/L'),
    new Unit('nitrate', 'µg/L'),
    new Unit('totalSuspendedSolids', 'mg/L'),
    new Unit('thermotolerantColiforms', 'NMP/100ml'),
    new Unit('pH', ''),
    new Unit('chrolophyllA', 'µg/L'),
    new Unit('biochemicalOxygenDemand', 'mg/L'),
    new Unit('phosphates', 'µg/L')
  ];

  @override
  void initState() {
    super.initState();

    _getElements();
  }

  Future _getElements() async {

    var waterBodies = await fetchWaterBodies();
    print("Number of waterbodies: ${waterBodies.total}");
    _waterBodies = waterBodies.data;

    var nodes = await fetchNodes();
    print("Number of nodes: ${nodes.total}");
    _wqMonitoringPoints = nodes.data;

    for (final wq in _wqMonitoringPoints) {
      print("wq: ${wq.toString()}");

      WQMonitoringPointAxis wqMPA = new WQMonitoringPointAxis();
      wqMPA.id = wq.id;
      wqMPA.name = wq.name;
      wqMPA.type = 'Punto de monitoreo de calidad del agua';
      wqMPA.active = false;
      wqMPA.dataLoaded = false;
      wqMPA.data = [];

      print("wqMPA $wqMPA");
      _yAxisList.add(wqMPA);
    }

    // wait for all futures to complete
    print("getElements() _yAxisList length: ${_yAxisList.length}");

    await _getIcampffs();
  }

  Future _getIcampffs() async {
    List<String> monitoringPoints = [];

    for (final waterBody in _waterBodies) {
      for (final mp in waterBody.puntosDeMonitoreo) {
        // indexOf returns -1 if element is not found.
        if (monitoringPoints.indexOf(mp) == -1) {
          print("mp: $mp");
          monitoringPoints.add(mp);
        }
      }
    }

    final string = json.encode(monitoringPoints);
    print("monitoringPoints_str: $string");

    var additionalFilters = '[{"trackedObject": {"inq": $string}}]';
    var data = await fetchData(additionalFilters);
    _data = data;
    print("_data: ${_data.length}");

    // format fetched data
    Map<String, WQMonitoringPointAxis> wqPointsAxisMap = {};

    for (var axis in _yAxisList) { // at this point only contains monitoring points
      if (axis is WQMonitoringPointAxis) {
        wqPointsAxisMap[axis.id] = axis;
        print("wqPointsAxisMap axis: ${wqPointsAxisMap[axis.id]}");
      }
    }

    print("wqPointsAxisMap length: ${wqPointsAxisMap.length}");

    for (var datum in _data) {
      if (datum.date != null && _icampffDates.indexOf(datum.date) == -1) {
        _icampffDates.add(datum.date);
      }

      WQMonitoringPointAxis axis = new WQMonitoringPointAxis();
      axis.data = [];
      var undefined = wqPointsAxisMap[datum.trackedObject];

      if (axis != undefined) {
        axis.data.add(datum);
      }

      for (var key in wqPointsAxisMap.keys) {
//          wqPointsAxisMap[key].data.sort((a: any, b: any) => a.date - b.date);
        wqPointsAxisMap[key].data.sort((a, b) => a.date.compareTo(b.date));
        wqPointsAxisMap[key].dataLoaded = true;
      }

      for (var waterBody in _waterBodies) {
        _icampffs[waterBody.id] = {};

        for (var date in _icampffDates) {
          var filteredData = data.where((d) =>
          d.date == date); //.toList(); //filteredData (Instance of 'Datum', ..., Instance of 'Datum')

          var icampffPerMonitoringPoint = waterBody.puntosDeMonitoreo.map((mp) {
            // waterBody.puntosDeMonitoreo == data.trackedObject
            var dataForThisDate = filteredData
            // returns the value of the first element in the array where predicate is true,
            // undefined otherwise
                .firstWhere((d) => d.trackedObject == mp);
//                print("dataForThisDate ${dataForThisDate}");
            return dataForThisDate == null ? -1 : dataForThisDate.icampff;
          }).where((ic) => ic != -1);

//          print("icampffPerMonitoringPoint.length ${icampffPerMonitoringPoint.length}");

          if (icampffPerMonitoringPoint.length != null) {
            // compute sum of an iterable
            _icampffs[waterBody.id][date] =
                icampffPerMonitoringPoint.reduce((pv, cv) => pv + cv)
                    / icampffPerMonitoringPoint.length;
          } else {
            _icampffs[waterBody.id][date] = -1;
          }
        }
      }

//      print("_icampffs $_icampffs");

      // _icampffs ==> one for each water body ...
      // {5daccf7da52adb394573ca72: {1507438800000: 29.58, 1529211600000: 34.12,
      // 1540702800000: 9.38, 1543554000000: 5.47, 1548565200000: 6.74, 1550984400000: 8.41,
      // 1554008400000: 11.07, 1556427600000: 47.09},

      // 5db289f6458f3171dfaf380b: {1507438800000: 43.41, 1529211600000: 10.97,
      // 1540702800000: 13.67, 1543554000000: 8.75, 1548565200000: 16.82,
      // 1550984400000: 16.86, 1554008400000: 10.63, 1556427600000: 15.44},

      // 5db3cb47a53e2a108358072b: {1507438800000: 28.785, 1529211600000: 38.335,
      // 1540702800000: 32.925, 1543554000000: 19.275, 1548565200000: 23.35,
      // 1550984400000: 21.995, 1554008400000: 21.185000000000002, 1556427600000: 34.0},

      // 5db4b2fb327b7d19875b3bc4: {1507438800000: 39.39, 1529211600000: 33.535, 1540702800000: 38.185,
      // 1543554000000: 28.509999999999998, 1548565200000: 32.955, 1550984400000: 26.435,
      // 1554008400000: 33.16, 1556427600000: 34.005},

      // 5db4e5a2b5986235dfe66005: {1507438800000: 40.125, 1529211600000: 22.794999999999998,
      // 1540702800000: 43.129999999999995, 1543554000000: 36.175, 1548565200000: 37.205,

      _icampffDates.sort((a, b) => a.compareTo(b));

      _waterBodies.forEach((wb) {
        WaterBodyAxis wbA = new WaterBodyAxis();

        wbA.id = wb.id;
        wbA.name = wb.name;
        wbA.type = 'Cuerpo de agua';
        wbA.active = true;
        wbA.dataLoaded = true;
        wbA.data = _icampffDates.map((date) => ({
          'icampff': this._icampffs[wb.id][date]
        })).toList();

        print("wbA $wbA");

        _yAxisList.add(wbA);
      });

    }

    setState(() {});

    print("getIcampff() _yAxisList length: ${_yAxisList.length}");

  }

  @override
  Widget build(BuildContext context) {
    var colors = '''[
    '#e6194b',
    '#3cb44b',
    '#ffe119',
    '#4363d8',
    '#f58231',
    '#911eb4',
    '#46f0f0',
    '#f032e6',
    '#bcf60c',
    '#fabebe',
    '#008080',
    '#e6beff',
    '#9a6324',
    '#fffac8',
    '#800000',
    '#aaffc3',
    '#808000',
    '#ffd8b1',
    '#000075',
    '#808080',
    '#ffffff',
    '#000000',
  ]''';

//    var textColor = 'black';
    var axisLineColor = 'black';
    var splitLineColor = '#c7c7c7';

    var series = [];
    var legendNames = [];
    var units = [];
    var commonSeriesConfig = '''{
    type: 'line',
    smooth: true,
    itemStyle: {
      borderColor: 'rgba(0,0,0,0.4)',
      borderWidth: 1,
    },
    lineStyle: {
      normal: {
        width: 3,
        shadowColor: 'rgba(0,0,0,0.4)',
        shadowBlur: 10,
        shadowOffsetY: 10,
      },
    },
  ''';

    for (var axis in _yAxisList) {
//      print("axis in _yAxisList!!!! ${_yAxisList.length}"); // 392
      if (!axis.active) {
        continue;
      }

      for (var activeSensor in axis.activeSensors) {
        print("axis: ${axis.name} with type ${axis.runtimeType} activeSensors: ${axis.activeSensors}");

        var name = "${axis.name}(${axis.sensors
            .firstWhere((s) => s.name == activeSensor)
            .title})";

        if (axis is WQMonitoringPointAxis) {

          print("WQMonitoringPointAxis axis.data ${axis.data}");

          var cache = {};
          for (var datum in axis.data) {
            cache[datum.date] = datum[activeSensor];
          }

//          series.add({
//          commonSeriesConfig,
//          name,
//          _icampffDates.map((date) => (cache[date] != null ? cache[date] : -1)),
//          });
//
        } else {

          print("WaterBodyAxis axis.data ${axis.data}");

          var data = axis.data.map((d) => d[activeSensor]).toList();
          var dataStr = json.encode(data);
          print("d[activeSensor] dataStr: $dataStr");

          var nameStr = json.encode(name).replaceAll('"', '\'');
          print("nameStr: $nameStr");

          var add = '''{
              type: 'line',
              name: $nameStr,
              data: $dataStr,
            }''';
          print("add: $add");

          series.add(add);
        }


        if (legendNames.indexOf(name) == -1) {
          legendNames.add(name);
          print("legendNames $legendNames");
        }

        var unit = _units.firstWhere((u) => u.getName == activeSensor);
//        print("activeSensor: $activeSensor");
//        print("unit: $unit");
        units.add(unit != null ? unit.getUnit : '');
//        print("units: ${units.length}");
      }
    }

    final legendNamesStr = json.encode(legendNames).replaceAll('"', '\'');
    print("legendNames_str: $legendNamesStr");

    final dates = _icampffDates.map((element) {
      return readTimestamp(element)[0];
    }).toList();

    print("_icampffDates:  $dates");

    var series2 = '''[
            {
              name: 'Caño Juan Angola(ICAMpff)',
              type: 'line',
              stack: 'total',
              data: [320, 302, 301, 334, 390, 330, 320]
            },
            {
              name: 'Laguna del cabrero(ICAMpff)',
              type: 'line',
              stack: 'total',
              data: [120, 132, 101, 134, 90, 230, 210]
            },
            {
              name: 'Laguna de chambacú(ICAMpff)',
              type: 'line',
              stack: 'total',
              data: [220, 182, 191, 234, 290, 330, 310]
            },
            {
              name: 'Ciénaga de las Quintas(ICAMpff)',
              type: 'line',
              stack: 'total',
              data: [150, 212, 201, 154, 190, 330, 410]
            },
            {
              name: 'Caño de bazurto(ICAMpff)',
              type: 'line',
              stack: 'total',
              data: [820, 832, 901, 934, 1290, 1330, 1320]
            },
            {
              name: 'Laguna de San Lázaro(ICAMpff)',
              type: 'line',
              stack: 'total',
              data: [832, 832, 901, 994, 1290, 1330, 1320]
            }
          ]
  ''';

    return Container(
      child: Echarts(
        extensions: [customThemeScript], //[darkThemeScript],
        extraScript: '''
        var base = +new Date(1968, 9, 3);
        var oneDay = 24 * 3600 * 1000;
        var date = [];

        var data = [Math.random() * 300];

        for (var i = 1; i < 20000; i++) {
            var now = new Date(base += oneDay);
            date.push([now.getFullYear(), now.getMonth() + 1, now.getDate()].join('/'));
            data.push(Math.round((Math.random() - 0.5) * 20 + data[i - 1]));
        }
        
      ''',

        option: '''{
          legend: {
            data: $legendNamesStr,  
            type: 'scroll',
//              orient: 'vertical',
            y: 50
          },
          toolbox: {
            feature: {
              dataZoom: {
                  yAxisIndex: 'none'
              },
              restore: {},
              saveAsImage: {
                title: 'Guardar',
                name: `grafico`,
              },                
            }
          },
          grid: {
            left: '3%',
            right: '4%',
            top: '30%',
            bottom: '3%',
            containLabel: true,
          },
          xAxis: {
            type: 'category',
            data: $dates,
          },
          yAxis: {
            type: 'value',
          },
          series: $series
        }
     ''',
      ),
      width: 300,
      height: 300,
    );
  }
}


