import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icam_app/models/node.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NodeDetailPage extends StatelessWidget {

  final Node node;
  NodeDetailPage(this.node);

  // google map setup
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('${node.name}'),
      ),
      body: Stack(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      child: Text('${node.name}',
                          style: new TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      child: Text('${node.location}',
                          style: new TextStyle(fontSize: 16.0)),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      child: Text('Status: ${node.status}',
                          style: new TextStyle(fontSize: 16.0)),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      child: Text(
                          'LAT: ${node.coordinates[0]} LON: ${node.coordinates[1]}',
                          style: new TextStyle(fontSize: 16.0)),
                    ),
                    // @TODO: nodeTypeId
//                Container(
//                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
//                  child: Text('NodeType: ${node.nodeTypeId}',
//                      style: new TextStyle(fontSize: 16.0)),
//                ),
//                Image.network(
//                  widget.location.imageUrl,
//                  width: 300.0,
//                  height: 300.0,
//                )
                  ],
                )
              ],
            ),
          ),
//          GoogleMap(
//            padding: EdgeInsets.all(1000.0),
//            mapType: MapType.satellite,
//            initialCameraPosition: CameraPosition(
//                target: LatLng(node.coordinates[0], node.coordinates[1]),
//                zoom: 18.0
//            ),
//            onMapCreated: (GoogleMapController controller) {
//              _controller.complete(controller);
//            },
//            markers: {
//              Marker(
//                markerId: MarkerId(node.id),
//                position: LatLng(node.coordinates[0], node.coordinates[1]),
//                infoWindow: InfoWindow(
//                    title: node.name,
//                    snippet: node.status,
//                ),
//              )
//            }
//          ),
//          Padding(
//            padding: EdgeInsets.all(16.0),
//            child: Align(
//              alignment: Alignment.bottomCenter,
//              child: Column(
//                children: <Widget>[
//                  Container(
//                    margin: EdgeInsets.fromLTRB(80.0, 0.0, 0.0, 10.0),
//                    padding: EdgeInsets.all(10.0),
//                    color: Colors.black87,
//                    child: Row(
//                      children: <Widget>[
//                        Expanded(
//                          child: RichText(
//                            text: TextSpan(
//                              text: '${node.location} ',
//                              style: new TextStyle(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 18.0,
//                              ),
//                              children: <TextSpan>[
//                                TextSpan(text: "                                         "),
//                                TextSpan(text: 'Status: ${node.status}', style: TextStyle(fontWeight: FontWeight.bold)),
//                              ],
//                            ),
//                          ),
////                          child: Text('${node.name}',
////                              style: new TextStyle(
////                                  color: Colors.white,
////                                  fontWeight: FontWeight.bold,
////                                  fontSize: 20.0)
////                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
        ],
      )
    );
  }
}