import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icam_app/models/node.dart' as node;
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/theme.dart';

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
//  final Set<Polygon> _polygons = {};
//  List<LatLng> _polygonLatLngs = List<LatLng>();

  _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    // add markers to map
    final nodes = await node.getNodeFromFakeServer();
    setState(() {
      _markers.clear();
      for (final node in nodes) {
        Marker marker = _addMarker(node);
        // add marker to map
        _markers.add(marker);
      }
    });

    // draw polygon to the map
    // Define the LatLng coordinates for the polygon's path.
//    _polygonLatLngs = [
//      LatLng(-75.52697, 10.41024),
//      LatLng(-75.52708, 10.41009),
//      LatLng(-75.52720, 10.41006)
//    ];

//    _polygons.add(Polygon(
//      points: _polygonLatLngs,
//      strokeWidth:  2,
//      strokeColor: Colors.yellow,
//      fillColor: Colors.yellow.withOpacity(0.15),
//      onTap: (){}
//    )
//    );
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  Marker _addMarker(node){

    // HEX/RGB to HSV color conversion:
    // 0xFF0288D1 ==> rgb(2, 119, 189) ==> hsl(320, 100%, 51%)
//    const double hue = 202;

    final marker = Marker(
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
    return marker;
  }

  Future<void> _showConventionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.fromLTRB(15, 15,15, 0),
          title: Text(
            'ICAMpff (estuary) values',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            padding: EdgeInsets.all(0),
            child: ListBody(
              children: <Widget>[
                _DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.black54,
                  text: 'Unavailable',
                ),
                _DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.red,
                  text: 'Poor (0-25)',
                ),
                _DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.orange,
                  text: 'Inadequate (26-50)',
                ),
                _DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.yellow,
                  text: 'Acceptable (51-70)',
                ),
                _DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.green,
                  text: 'Adequate (71-90)',
                ),
                _DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.blue[900],
                  text: 'Optimal (91-100)',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
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

  Widget button(Function function, IconData icon, String heroTag) {
    return new FloatingActionButton(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _buildBody(context),
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
              zoom: 14.0
          ),
          minMaxZoomPreference: MinMaxZoomPreference(13.0, 15.0),
          mapType: _currentMapType,
          markers: _markers,
//          polygons: _polygons,
          onCameraMove: _onCameraMove,
          mapToolbarEnabled: false // disable google maps navigation button
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
                SizedBox(height: 16.0)
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class _DialogItem extends StatelessWidget {
  const _DialogItem({
    Key key,
    this.icon,
    this.color,
    this.text,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      padding: EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: color),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 5, end: 0),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
