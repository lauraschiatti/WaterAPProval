import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/theme.dart';
import 'package:icam_app/models/datum.dart';
import 'package:icam_app/services/datum_service.dart';
import 'package:icam_app/services/water_body_service.dart';
import 'package:icam_app/services/node_service.dart';
//import 'package:icam_app/classes/dark_theme_script.dart' show darkThemeScript;
import 'package:icam_app/classes/echarts_theme_script.dart' show customThemeScript;

class ExportControllerPage extends StatefulWidget {
  ExportControllerPage();//{Key key}) : super(key: key);

  final Key _chartKey = UniqueKey();

  @override
  ExportControllerPageState createState() => ExportControllerPageState();
}


class ExportControllerPageState extends State<ExportControllerPage> {

  Future _futureData;

  @override
  void initState() {
    super.initState();

    var additionalFilters = '[{"trackedObject": {"inq": ["5dacbdcaa52adb394573ca71","5db298ae458f3171dfaf380c","5db3cb23a53e2a1083580729","5db3cb31a53e2a108358072a","5db4b2a9327b7d19875b3bc2"]}}]';
    _futureData = fetchData(additionalFilters);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
                child: Column(
                    children: <Widget>[
                      Padding(
                        child: Text(
                            'Export data',
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
                      FutureBuilder(
                        future: _futureData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print("data ${snapshot.data}");
                            return Text("Dataaa");
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      )
                    ]
                )
            )
        )
    );
  }
}


/////////////////////////////////////////////////////////////////////

class Unit{
  String name;
  String unit;

  Unit(this.name, this.unit);
}

class SensorAxis {
  String name;
  String title;

  // constructor with syntactic sugar
  SensorAxis(this.name, this.title);
}

class Axis {
  String id;
  String name;
  String type;
  bool active;
  bool dataLoaded;
  List data;
  List<SensorAxis> sensors;
  List<String> activeSensors;

  Axis(this.id, this.name, this.type, this.active, this.dataLoaded, this.data);

//  @override
//  String toString() {
//    return "Axis [id=${this.id},name=${this.name},type=${this.type}"
//        ",active=${this.active},dataLoaded=${this.dataLoaded},sensors=${this.sensors}"
//        ",activeSensors=${this.activeSensors}]";
//  }
}

class WQMonitoringPointAxis implements Axis {

  @override
  String id;
  @override
  String name;
  @override
  String type;
  @override
  bool active;
  @override
  bool dataLoaded;
  @override
  List data = [];

  @override
  List<SensorAxis> sensors = [
    new SensorAxis('icampff', 'ICAMpff'),
    new SensorAxis('dissolvedOxygen', 'Oxígeno disuelto'),
    new SensorAxis('nitrate', 'Nitratos'),
    new SensorAxis('totalSuspendedSolids', 'Sólidos suspendidos totales'),
    new SensorAxis('thermotolerantColiforms', 'Coliformes termotolerantes'),
    new SensorAxis('thermotolerantColiforms', 'Coliformes termotolerantes'),
    new SensorAxis('pH', 'pH'),
    new SensorAxis('chrolophyllA', 'Clorofila A'),
    new SensorAxis('biochemicalOxygenDemand', 'Demanda bioquímica de oxígeno'),
    new SensorAxis('phosphates', 'Fosfatos')
  ];

  @override
  List<String> activeSensors = [];

//  WQMonitoringPointAxis(id, name, type, active, dataLoaded, data, this._sensors, this._activeSensors)
//      : super(id, name, type, active, dataLoaded, data);

  @override
  String toString() {
    return "WQMonitoringPointAxis [id=${this.id},name=${this.name},type=${this.type}"
        ",active=${this.active},dataLoaded=${this.dataLoaded},data=${this.data}"
        ",sensors=${this.sensors},activeSensors=${this.activeSensors}]";
  }
}

class WaterBodyAxis implements Axis {

  @override
  String id;
  @override
  String name;
  @override
  String type;
  @override
  bool active;
  @override
  bool dataLoaded;
  @override
  List data = [];

  @override
  List<SensorAxis> sensors = [
    SensorAxis('icampff', 'ICAMpff')
  ];

  @override
  List<String> activeSensors = ['icampff'];

  @override
  String toString() {
    return "WaterBodyAxis [id=${this.id},name=${this.name},type=${this.type}"
        ",active=${this.active},dataLoaded=${this.dataLoaded},data=${this.data}"
        ",sensors=${this.sensors},activeSensors=${this.activeSensors}]";
  }

}

////////////////////////////////////////////////////////////////////

class Chart extends StatefulWidget {
  ///key is required, otherwise map crashes on hot reload
  Chart({ @required Key key}) : super(key:key);

  @override
  _ChartState createState() => _ChartState();
}


class _ChartState extends State<Chart> {

  var _waterBodies;
  var _wqMonitoringPoints;
  List<Axis> _yAxisList = [];
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
      print("wq: $wq");

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

    print("_yAxisList length: ${_yAxisList.length}");

    _getIcampffs();
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

//    print("monitoringPoints for ${monitoringPoints.length}");

    final string = json.encode(monitoringPoints);
    print("monitoringPoints_str: $string");

    var additionalFilters = '[{"trackedObject": {"inq": $string}}]';
    var data = await fetchData(additionalFilters);
    _data = data;
    print("_data: $_data");

    // format fetched data
    Map<String, WQMonitoringPointAxis> wqPointsAxisMap = {};

    for (var axis in _yAxisList) {
      if (axis is WQMonitoringPointAxis) {
        wqPointsAxisMap[axis.id] = axis;
        print("wqPointsAxisMap: $wqPointsAxisMap");
      }
    }

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
      print("axis.data ${axis.data}");

      for (var key in wqPointsAxisMap.keys) {
//          wqPointsAxisMap[key].data.sort((a: any, b: any) => a.date - b.date);
        wqPointsAxisMap[key].data.sort((a, b) => a.date.compareTo(b.date));
        wqPointsAxisMap[key].dataLoaded = true;
      }

      for (var waterBody in _waterBodies) {
        _icampffs[waterBody.id] = {};

        for (var date in _icampffDates) {
          var filteredData = data.where((d) =>
          d.date ==
              date); //.toList(); //filteredData (Instance of 'Datum', ..., Instance of 'Datum')

          var icampffPerMonitoringPoint = waterBody.puntosDeMonitoreo
              .map((mp) {
            // waterBody.puntosDeMonitoreo == data.trackedObject
            var dataForThisDate = filteredData
            // returns the value of the first element in the array where predicate is true,
            // undefined otherwise
                .firstWhere((d) => d.trackedObject == mp);

//                print("dataForThisDate ${dataForThisDate}");
            return dataForThisDate == null ? -1 : dataForThisDate.icampff;
          })
              .where((ic) => ic != -1);
          //.toList();

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

      _icampffDates.sort((a, b) => a.compareTo(b));
      print("_icampffDates sorted: $_icampffDates");

      _waterBodies.forEach((wb) {
        WaterBodyAxis wbA = new WaterBodyAxis();

        wbA.id = wb.id;
        wbA.name = wb.name;
        wbA.type = 'Cuerpo de agua';
        wbA.active = true;
        wbA.dataLoaded = true;
//        wbA.data;

        print("_icampffDates type: ${_icampffDates
            .runtimeType}"); // List<dynamic>


//        _icampffDates
//            .map((date) =>
//        ({
//            //icampff: this.icampffs[wb.id][date],
//            print("_icampffs[wb.id][date] ${date}"),
//        }));

//        (dictionary['key'] as List).map((item)=> {}).toList();

        print("wbA $wbA");

        _yAxisList.add(wbA);
      });

      setState(() {

      });

//      configureChart();

    }
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
        var name = "${axis.name}(${axis.sensors.firstWhere((s) => s.name == activeSensor).title})";

//        if (axis is WQMonitoringPointAxis) {
//          var cache = {};
//          for (var datum in axis.data) {
//            cache[datum.date] = datum[activeSensor];
//          }
//
//          series.add({
//          commonSeriesConfig,
//          name,
//          _icampffDates.map((date) => (cache[date] != null ? cache[date] : -1)),
//          });
//
//        } else {
//          series.add({
//          commonSeriesConfig,
//          name,
//          axis.data.map((d) => d[activeSensor]),
//          });
//        }

        if (legendNames.indexOf(name) == -1) {
          legendNames.add(name);
          print("legendNames $legendNames");
        }
        var unit = _units.firstWhere((u) => u.name == activeSensor);
        units.add(unit != null ? unit.unit : '');

      }

    }

    final legendNamesStr = json.encode(legendNames).replaceAll('"', '\'');
    print("legendNames_str: $legendNamesStr");

    return Container(
      child: Echarts(
        extensions: [customThemeScript],//[darkThemeScript],
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
              data: ['Day1', 'Day2', 'Day3', 'Day4', 'Day5', 'Day6', 'Day7']
            },
            yAxis: {
              type: 'value',
            },
            series: [
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
          }
       ''',
      ),
      width: 300,
      height: 300,
    );
  }
}

