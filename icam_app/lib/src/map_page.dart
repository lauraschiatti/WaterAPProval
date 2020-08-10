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

  static const LatLng _center = const LatLng(
      10.418252, -75.537818); // center at cartagena
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
            icon: BitmapDescriptor.defaultMarker,
        );
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

  _onAddMarkerButtonPressed() {
    // HEX/RGB to HSV color conversion:
    // 0xFF0288D1 ==> rgb(2, 119, 189) ==> hsl(320, 100%, 51%)
//    const double hue = 202;

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
              title: "This is a title",
              snippet: "This is a snippet"
          ),
          icon: BitmapDescriptor.defaultMarker //.defaultMarkerWithHue(hue)
      ));
    });
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
        size: 36.0,
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

        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                button(_onMapTypeButtonPressed, Icons.map, "map"),
                SizedBox(height: 16.0),
                button(_onAddMarkerButtonPressed, Icons.add_location,
                    "add_location"),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}