import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'dart:async';
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:icam_app/models/node.dart' as node;
import 'package:icam_app/models/water_body.dart' as waterBody;
import 'package:icam_app/classes/widgets.dart';


class MapControllerPage extends StatefulWidget {
  MapControllerPage({Key key}) : super(key: key);

  @override
  MapControllerPageState createState() => MapControllerPageState();
}

class MapControllerPageState extends State<MapControllerPage> {

  // google map setup
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(10.418252, -75.537818);
  LatLng _lastMapPosition = _center; // default center
  MapType _currentMapType = MapType.normal;

  // map components
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};

  _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    // add markers to map
    final nodes = await node.getNodeFromFakeServer();
    _addMarkers(nodes);

    // draw polygons to the map
    final water_bodies = await waterBody.getNodeFromFakeServer();
    _addPolygons(water_bodies);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  // markers
  _addMarkers(nodes) {
    // HEX/RGB to HSV color conversion:
    // 0xFF0288D1 ==> rgb(2, 119, 189) ==> hsl(320, 100%, 51%)
    // const double hue = 202;
    setState(() {
      _markers.clear();
      for (final node in nodes) {
        Marker marker = Marker(
          markerId: MarkerId(node.id),
          position: LatLng(node.coordinates[0], node.coordinates[1]),
          infoWindow: InfoWindow(
              title: node.name,
              snippet: node.status,
              onTap: () {
                // InfoWindow clicked
                Navigator.pushNamed(
                    context,
                    nodeDetailRoute,
                    arguments: node
                );
              }
          ),
          icon: BitmapDescriptor.defaultMarker, //.defaultMarkerWithHue(hue)
        );
        _markers.add(marker); // add marker to map
      }
    });

  }

  // polygons
  _addPolygons(water_bodies){
    setState(() {
      _polygons.clear();

      print("Number of waterbodies: ${water_bodies.length}");

      for (final body in water_bodies) {
        String type = body.geometry.type;
        List<List<List<dynamic>>> coordinates = body.geometry.coordinates;

        String waterBodyId = body.waterBodyId;
        String name = body.properties.name;
        double icam = body.properties.icam;

        if(type == "Polygon"){
          Polygon polygon = _addPolygon(coordinates[0], name, icam);
          _polygons.add(polygon); // add polygon to map
          print("Polygon: id: $waterBodyId, name: $name added");

        } else if(type == "MultiPolygon"){
          print("MultiPolygon: waterBodyId: $waterBodyId, name: $name");
          print(" # polygons: ${coordinates.length}");

          for(var i = 0 ; i < coordinates.length ; i++) { // # polygons
            for(var j = 0; j < coordinates[i].length; j++){
              print(" # points polygon $i: ${coordinates[i][j].length}");

              Polygon polygon = _addPolygon(coordinates[i][j], name, icam);
              _polygons.add(polygon);
            }
          }
        }
      }

    });
  }

  Polygon _addPolygon(coordinates, name, icam){

    // define the LatLng coordinates for the polygon's path
    List<LatLng> points = List<LatLng>();
    for(var i=0 ; i < coordinates.length ; i++) {
      var ltlng= LatLng(coordinates[i][1], coordinates[i][0] );
      points.add(ltlng);
    }

    var uuid = Uuid();
    String polygonId = uuid.v4();

    Color color = _getColorByIcamRange(icam);

    final polygon =  Polygon(
        polygonId: PolygonId(polygonId),
        points: points,
        consumeTapEvents: true,
        strokeColor: color,
        strokeWidth: 1,
        fillColor: color,
        onTap: () => _showWaterBodyDialog(name, icam)
    );

    return polygon;
  }

  // get waterBody color according to icam value
  Color _getColorByIcamRange(icam){

    if (icam >= 0 && icam <= 25) {
      return Colors.redAccent[700];
    }
    else if (icam >= 26 && icam <= 50) {
      return Colors.orange;
    }
    else if (icam >= 51 && icam <= 70) {
      return Colors.yellow[600];
    }
    else if (icam >= 71 && icam <= 90) {
      return Colors.green;
    }
    else if (icam >= 91 && icam <= 100) {
      return myTheme.primaryColor;
    }

    // if no case matches
    return Colors.black54;
  }

  // water bodies on Tap AlertDialog
  Future<void> _showWaterBodyDialog(name, icam) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            name,
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
//            textAlign: TextAlign.left,
          ),
          content: SingleChildScrollView(
            padding: EdgeInsets.all(0),
            child: ListBody(
              children: <Widget>[
                Text("ICAMpff: $icam",
                    style: TextStyle(fontStyle: FontStyle.italic)
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(getTranslated(context, "export")),
              color: Colors.redAccent[700],
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop(); // TODO: go to export page
              },
            ),
            FlatButton(
              child: Text(getTranslated(context, "close")),
              color: myTheme.primaryColor,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // FloatingActionButton
  Widget button(Function function, IconData icon, String heroTag) {
    return new FloatingActionButton(
//      mini: true,
      heroTag: heroTag,
      // to avoid scheduler warning
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: myTheme.primaryColor,
      child: Icon(
        icon,
        size: 34.0,
        color: Colors.white,
      ),
    );
  }

  // control MapType
  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  // ICAMpff values AlertDialog
  Future<void> _showConventionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.fromLTRB(15, 15,15, 0),
          title: Text(
            getTranslated(context, "icam_values"),
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            padding: EdgeInsets.all(0),
            child: ListBody(
              children: <Widget>[
                DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.black54,
                  text: getTranslated(context, "unavailable"),
                ),
                DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.redAccent[700],
                  text: getTranslated(context, "poor"),
                ),
                DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.orange,
                  text: getTranslated(context, "inadequate"),
                ),
                DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.yellow[600],
                  text: getTranslated(context, "acceptable"),
                ),
                DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.green,
                  text: getTranslated(context, "adequate"),
                ),
                DialogItem(
                  icon: Icons.brightness_1,
                  color: myTheme.primaryColor,
                  text: getTranslated(context, "optimal"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(getTranslated(context, "close")),
              color: myTheme.primaryColor,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _buildBody(context),
    );
  }

  _buildFloatingActionButton(){
    return Padding(
      padding: const EdgeInsets.only(right: 130.0),
      child: FloatingActionButton.extended(
        icon: Icon(
          Icons.location_searching,
          color: Colors.white,
        ), //
        label: Text(
          getTranslated(context, "map_text"),
          style: TextStyle(
              fontSize: 12,
              color: Colors.white
          ),
        ), //
        backgroundColor: Colors.black54,
        onPressed: () {
          Navigator.pushNamed(context, cgenaRoute); // cartagena_page
        },
      ),
    );
  }

  _buildBody(context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          padding: EdgeInsets.fromLTRB(100.0,0,0,0),
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0
          ),
          minMaxZoomPreference: MinMaxZoomPreference(null, 16.0),
          mapType: _currentMapType,
          markers: _markers,
          polygons: _polygons,
          onCameraMove: _onCameraMove,
          mapToolbarEnabled: false, // disable google maps navigation button
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,

        ),
        Padding(
          padding: EdgeInsets.all(18.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                button(_onMapTypeButtonPressed, Icons.map, "map"),
                SizedBox(height: 16.0),
                button(_showConventionDialog, Icons.data_usage, "show_convention"),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ICAMpff values Items
