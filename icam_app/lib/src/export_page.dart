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

    var additionalFilters = '[{"trackedObject": {"inq": ["5dacbdcaa52adb394573ca71", "5db3cb31a53e2a108358072a"]}}]';
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
                          height: 340,

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




class Chart extends StatefulWidget {
  ///key is required, otherwise map crashes on hot reload
  Chart({ @required Key key}) : super(key:key);

  @override
  _ChartState createState() => _ChartState();
}


class _ChartState extends State<Chart> {

  @override
  void initState() {
    super.initState();

//    getElements();
//    getIcampffs();
  }

  List<Map<String, Object>> _data1 = [{ 'name': 'Please wait', 'value': 0 }];

  var _nodes = {};
  var _waterBodies = {};

  getElements() async {
//    final waterBodies = await fetchWaterBodies();
//    final nodes = await fetchNodes();
//
//    setState(() {
//      this._nodes = waterBodies.data;
//    });

//    for(Future<Node> f in nodes) {
//      print(await f);
//    }
//
//    const dataObj = [{
//      'name': 'Jan',
//      'value': 8726.2453,
//    }, {
//      'name': 'Feb',
//      'value': 2445.2453,
//    }, {
//      'name': 'Mar',
//      'value': 6636.2400,
//    }, {
//      'name': 'Apr',
//      'value': 4774.2453,
//    }, {
//      'name': 'May',
//      'value': 1066.2453,
//    }, {
//      'name': 'Jun',
//      'value': 4576.9932,
//    }, {
//      'name': 'Jul',
//      'value': 8926.9823,
//    }];
//
//    this.setState(() {
//      this._data1 = dataObj;
////      this._nodes = nodes;
//    });
  }


  getIcampffs() async {
//    var additionalFilters = '[{"trackedObject": {"inq": ["5dacbdcaa52adb394573ca71", "5db3cb31a53e2a108358072a"]}}]';
//    _futureData = fetchData(additionalFilters);
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

    var textColor = 'black';


    return Container(
      child: Echarts(
        option: '''{
        
          tooltip: {
              trigger: 'axis'
          },
          legend: {
              data: ['邮件营销', '联盟广告', '视频广告', '直接访问', '搜索引擎']
          },
          dataZoom: [
            {
              type: 'inside',
              throttle: 50,
            },
          ],
          grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true,
          },
          toolbox: {
            show: true,
            feature: {
              saveAsImage: {
                title: 'Guardar',
                name: `grafico`,
              },
            },
          },
          backgroundColor: '#fafafa',
          color: $colors,
          
          xAxis: {
            type: 'category',
            boundaryGap: false,
            data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
          },
          yAxis: {
              type: 'value'
          },
          series: [
              {
                  name: '邮件营销',
                  type: 'line',
                  stack: '总量',
                  data: [120, 132, 101, 134, 90, 230, 210]
              },
              {
                  name: '联盟广告',
                  type: 'line',
                  stack: '总量',
                  data: [220, 182, 191, 234, 290, 330, 310]
              },
              {
                  name: '视频广告',
                  type: 'line',
                  stack: '总量',
                  data: [150, 232, 201, 154, 190, 330, 410]
              },
              {
                  name: '直接访问',
                  type: 'line',
                  stack: '总量',
                  data: [320, 332, 301, 334, 390, 330, 320]
              },
              {
                  name: '搜索引擎',
                  type: 'line',
                  stack: '总量',
                  data: [820, 932, 901, 934, 1290, 1330, 1320]
              }
          ]
      } ''',
      ),
      width: 300,
      height: 300,
    );
  }
}


