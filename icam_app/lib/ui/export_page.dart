import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/services/datum_service.dart';
import 'package:icam_app/services/water_body_service.dart';
import 'package:icam_app/services/node_service.dart';
import 'package:icam_app/classes/echarts_theme_script.dart' show customThemeScript;
import 'package:icam_app/classes/chart_classes.dart';
import 'package:icam_app/classes/utils.dart';

class ExportControllerPage extends StatefulWidget {
  ExportControllerPage();

  final Key _chartKey = UniqueKey();

  @override
  ExportControllerPageState createState() => ExportControllerPageState();
}


class ExportControllerPageState extends State<ExportControllerPage> {

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    _buildChart(){
      return SingleChildScrollView(
          child: Center(
              child: Column(
                  children: <Widget>[
                    Padding(
                      child: Text(
                        getTranslated(context, "chart_explanation"),
                        style: TextStyle(
                            fontSize: 14
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                        // TODO: scroll horizontally the chart
                        width: 380,
                        height: 400,
                        child: FittedBox(
                            child: Chart(key:widget._chartKey),
                        )
                    ),
                    SizedBox(height: 10),
                    Text("CJA: Caño Juan Angola - ICAMpff \n"
                        "Ldca: Laguna del cabrero - ICAMpff \n"
                        "Ldc : Laguna de chambacú - ICAMpff \n"
                        "CdlQ: Ciénaga de las Quintas - ICAMpff \n"
                        "Cdb: Caño de bazurto - ICAMpff \n"
                        "LdSL: Laguna de San Lázaro - ICAMpff \n",
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),


                    )
                  ]
              )
          )
      );
    }




    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "visualize_data"))
      ),
      body:
        _buildChart(),
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
    new Unit('chlorophyllA', 'µg/L'),
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

      _icampffDates.sort((a, b) => a.compareTo(b));

    }

    print("_icampffs[waterBody.id] $_icampffs");

    _waterBodies.forEach((wb) {
        WaterBodyAxis wbA = new WaterBodyAxis();

        wbA.id = wb.id;
        wbA.name = wb.name;
        wbA.type = 'Cuerpo de agua';
        wbA.active = true;
        wbA.dataLoaded = true;
        wbA.data = _icampffDates.map((date) => ({
          'icampff': double.parse(this._icampffs[wb.id][date].toStringAsFixed(2))
        })).toList();

        print("wbA $wbA");

        _yAxisList.add(wbA);
      });

    setState(() {});

    print("getIcampff() _yAxisList length: ${_yAxisList.length}");

  }


  String getInitials({String string, int limitTo}) {
    var buffer = StringBuffer();
    var split = string.split(' ');
    for (var i = 0 ; i < (limitTo ?? split.length); i ++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
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

    var series = [];
    var legendNames = [];
    var units = [];
    var commonSeriesConfig = '''
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
      if (!axis.active) {
        continue;
      }

      for (var activeSensor in axis.activeSensors) {
        print("axis: ${axis.name} with type ${axis.runtimeType} activeSensors: ${axis.activeSensors}");

        String name = "${axis.name}(${axis.sensors
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

          // get name initials ==> same string that the one considered as legendNames

          String wbname;
          if(name == 'Laguna del cabrero(ICAMpff)'){
            wbname = "Ldca";
          } else {
            wbname =  getInitials(string: name);
          }

          var nameStr = json.encode(wbname).replaceAll('"', '\'');
          print("nameStr: $nameStr");

          var add = '''{
              $commonSeriesConfig
              name: $nameStr,
              data: $dataStr,
            }''';
          print("add: $add");

          series.add(add);
        }


        legendNames.add(name);
        print("legendNames $legendNames");

        var unit = _units.firstWhere((u) => u.getName == activeSensor);
//        print("activeSensor: $activeSensor");
//        print("unit: $unit");
        units.add(unit != null ? unit.getUnit : '');
//        print("units: ${units.length}");
      }
    }


    // legend Names

    final legendNamesStr = json.encode(legendNames).replaceAll('"', '\'');
    print("legendNames_str: $legendNamesStr");

    final legendNamesInitials = legendNames.map((e) {

      String wbname;
      if(e == 'Laguna del cabrero(ICAMpff)'){
        wbname = "Ldca";
      } else {
        wbname =  getInitials(string: e);
      }
      return wbname;
    }).toList();

    final legendNamesInitialsStr = json.encode(legendNamesInitials).replaceAll('"', '\'');
    print("legendNamesInitials_str: $legendNamesInitialsStr");


    // dates
    final dates = _icampffDates.map((element) {
      return readTimestamp(element)[0];
    }).toList();

    final datesStr = json.encode(dates).replaceAll('"', '\'');
    print("dates_str: $datesStr");

    print("dates:  $dates");

    return Container(
//      child: ListView.builder(
//        itemCount: _yAxisList.length,
//        itemBuilder: (BuildContext ctxt, int index) {
//            if (_yAxisList[index] is WQMonitoringPointAxis) {
//              return Text("${_yAxisList[index].type}");
//            } else {
//              return Text("${_yAxisList[index].type}");
//
//            }
//        }
//      ),

      child: Echarts(
        extensions: [customThemeScript],
        option: '''{
          color: $colors,
          tooltip: {
              trigger: 'axis',
              position: function (pt) {
                  return [pt[0], '3%'];
              }
          },
          legend: {
            data: $legendNamesInitialsStr,
//            type: 'scroll',
//              orient: 'vertical',
            y: 50
          },
//          toolbox: {
//            feature: {
//              saveAsImage: {
//                show: true,
//                title: 'Guardar',
//                name: `grafico`
//              },
//            }
//          },
          grid: {
            left: '3%',
            right: '4%',
            top: '35%',
            bottom: '2%',
            containLabel: true,
          },
          xAxis: {
            type: 'category',
            data: $datesStr,
          },
          yAxis: {
            type: 'value',
          },
          series: $series
        }
     ''',
      ),
      width: 300,
      height: 300, //800
    );
  }

}